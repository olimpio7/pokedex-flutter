import 'package:flutter/material.dart';
import '../main.dart';
import '../database/app_database.dart';
import '../models/pokemon.dart';
import '../repositories/poke_api_repository.dart';

class TeamDetailsScreen extends StatefulWidget {
  final Team team;
  const TeamDetailsScreen({super.key, required this.team});

  @override
  State<TeamDetailsScreen> createState() => _TeamDetailsScreenState();
}

class _TeamDetailsScreenState extends State<TeamDetailsScreen> {
  final PokeApiRepository _api = PokeApiRepository();
  List<Pokemon> _pokemons = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTeamPokemons();
  }

  Future<void> _loadTeamPokemons() async {
    setState(() => _isLoading = true);
    final teamPokemons = await teamPokemonRepository.getPokemonsByTeam(widget.team.teamId);
    
    List<Pokemon> loaded = [];
    for (var tp in teamPokemons) {
      try {
        final p = await _api.fetchPokemonById(tp.pokemonId);
        loaded.add(p);
      } catch (e) {
        continue;
      }
    }

    if (!mounted) return;
    setState(() {
      _pokemons = loaded;
      _isLoading = false;
    });
  }

  void _addPokemon() {
    if (_pokemons.length >= 6) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('O time já atingiu o limite de 6 Pokémons!')));
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75, 
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text('Selecione um Pokémon', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Expanded(
                child: FutureBuilder<List<Pokemon>>(
                  future: favoriteRepository.getAllFavorites(),
                  builder: (context, snapshot) {
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
                      itemBuilder: (context, index) {
                        final p = list[index];
                        return GestureDetector(
                          onTap: () async {
                            final nav = Navigator.of(context);
                            bool exists = await teamPokemonRepository.isPokemonInTeam(teamId: widget.team.teamId, pokemonId: p.id);
                            
                            if (exists) {
                              if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Este Pokémon já está no time!')));
                              return;
                            }

                            await teamPokemonRepository.addPokemonToTeam(teamId: widget.team.teamId, pokemonId: p.id);
                            nav.pop();
                            _loadTeamPokemons();
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
                                  child: Image.network(p.image),
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

  Future<void> _removePokemon(int pokemonId) async {
    await teamPokemonRepository.removePokemonFromTeam(teamId: widget.team.teamId, pokemonId: pokemonId);
    _loadTeamPokemons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE53935),
      appBar: AppBar(
        title: Text(widget.team.name, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFFE53935),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _pokemons.isEmpty
                ? const Center(
                    child: Text(
                      'O time está vazio. Adicione membros!',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _pokemons.length,
                    itemBuilder: (context, index) {
                      final p = _pokemons[index];
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
                            child: Image.network(p.image),
                          ),
                          title: Text(p.name.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Text('ID: #${p.id}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
                            onPressed: () => _removePokemon(p.id),
                          ),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addPokemon,
        backgroundColor: const Color(0xFFE53935),
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          'Adicionar ao Time (${_pokemons.length}/6)', 
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
