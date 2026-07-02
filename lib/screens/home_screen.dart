import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/screens/details_screen.dart';
import 'package:pokedex/screens/favorites_screen.dart';
import 'package:pokedex/screens/teams_screen.dart';
import 'package:pokedex/screens/trainer_screen.dart';
import 'package:pokedex/widgets/pokemon_card.dart';
import '../blocs/home/home_bloc.dart';
import '../blocs/home/home_event.dart';
import '../blocs/home/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE53935),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Pokédex',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.shield, color: Colors.white),
                    tooltip: 'Meus Times',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TeamsScreen(),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.person, color: Colors.white),
                    tooltip: 'Treinador',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TrainerScreen(),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                    tooltip: 'Favoritos',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FavoritesScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (value) {
                  context.read<HomeBloc>().add(SearchPokemonsEvent(value));
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Buscar Pokémon (nome ou #id)...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xffF5F5F5),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is HomeError) {
                      return Center(child: Text('Erro: ${state.message}'));
                    } else if (state is HomeLoaded) {
                      final pokemons = state.filteredPokemons;

                      if (pokemons.isEmpty) {
                        return const Center(
                          child: Text(
                            'Nenhum Pokémon encontrado para essa busca.',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        );
                      }

                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          crossAxisSpacing: 10, 
                          mainAxisSpacing: 12, 
                          childAspectRatio: 0.75, 
                        ),
                        itemCount: pokemons.length,
                        itemBuilder: (context, index) {
                          return PokemonCard(
                            pokemon: pokemons[index],
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DetailsScreen(pokemon: pokemons[index]),
                                ),
                              );
                            },
                          );
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}