import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../database/app_database.dart';
import '../repositories/favorite_repository.dart';
import '../models/pokemon.dart';
import '../blocs/team_details/team_details_bloc.dart';
import '../blocs/team_details/team_details_event.dart';
import '../blocs/team_details/team_details_state.dart';

class TeamDetailsScreen extends StatelessWidget {
  final Team team;
  const TeamDetailsScreen({super.key, required this.team});

  void _addPokemon(BuildContext context, List<Pokemon> currentPokemons) {
    if (currentPokemons.length >= 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('O time já atingiu o limite de 6 Pokémons!')));
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (bottomSheetContext) {
        return Container(
          height: MediaQuery.of(bottomSheetContext).size.height * 0.75, 
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text('Selecione um Pokémon', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Expanded(
                child: FutureBuilder<List<Pokemon>>(
                  future: context.read<FavoriteRepository>().getAllFavorites(),
                  builder: (ctx, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text(
                          'Você não tem Pokémons favoritados.\nFavoritar primeiro!',
                          textAlign: TextAlign.center,
                        )
                      );
                    }
                    
                    final list = snapshot.data!;
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 120, 
                        crossAxisSpacing: 10, 
                        mainAxisSpacing: 10,
                      ),
                      itemCount: list.length,
                      itemBuilder: (ctx, index) {
                        final p = list[index];
                        return GestureDetector(
                          onTap: () {
                            context.read<TeamDetailsBloc>().add(
                              AddPokemonToTeamEvent(teamId: team.teamId, pokemonId: p.id)
                            );
                            Navigator.pop(bottomSheetContext);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.network(
                                    p.image,
                                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.catching_pokemon, color: Colors.grey),
                                  ),
                                )),
                                Text(
                                  p.name.toUpperCase(), 
                                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                              ],
                            ),
                          ),
                        );
                      }
                    );
                  }
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _removePokemon(BuildContext context, int pokemonId) {
    context.read<TeamDetailsBloc>().add(
      RemovePokemonFromTeamEvent(teamId: team.teamId, pokemonId: pokemonId)
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TeamDetailsBloc, TeamDetailsState>(
      listener: (context, state) {
        if (state is TeamDetailsActionError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is TeamDetailsError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFE53935),
        appBar: AppBar(
          title: Text(team.name, style: const TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFFE53935),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: BlocBuilder<TeamDetailsBloc, TeamDetailsState>(
            builder: (context, state) {
              if (state is TeamDetailsLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              
              List<Pokemon> pokemons = [];
              if (state is TeamDetailsLoaded) {
                pokemons = state.pokemons;
              } else if (state is TeamDetailsActionError) {
                pokemons = state.currentPokemons;
              }

              if (pokemons.isEmpty) {
                return const Center(
                  child: Text(
                    'O time está vazio. Adicione membros!',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: pokemons.length,
                itemBuilder: (context, index) {
                  final p = pokemons[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8),
                      leading: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12)
                        ),
                        child: Image.network(
                          p.image,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.catching_pokemon, color: Colors.grey),
                        ),
                      ),
                      title: Text(p.name.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('ID: #${p.id}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                        onPressed: () => _removePokemon(context, p.id),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        floatingActionButton: BlocBuilder<TeamDetailsBloc, TeamDetailsState>(
          builder: (context, state) {
            int count = 0;
            List<Pokemon> current = [];
            if (state is TeamDetailsLoaded) {
              count = state.pokemons.length;
              current = state.pokemons;
            } else if (state is TeamDetailsActionError) {
              count = state.currentPokemons.length;
              current = state.currentPokemons;
            }

            return FloatingActionButton.extended(
              onPressed: () => _addPokemon(context, current),
              backgroundColor: const Color(0xFFE53935),
              icon: const Icon(Icons.add, color: Colors.white),
              label: Text(
                'Adicionar ao Time ($count/6)', 
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
