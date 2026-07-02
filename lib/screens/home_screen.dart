import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import 'package:pokedex/screens/details_screen.dart';
import 'package:pokedex/screens/favorites_screen.dart';
import 'package:pokedex/screens/teams_screen.dart';
import 'package:pokedex/screens/trainer_screen.dart';
import 'package:pokedex/widgets/pokemon_card.dart';

import 'package:pokedex/repositories/poke_api_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PokeApiRepository _api = PokeApiRepository();
  late Future<List<Pokemon>> _pokemonsFuture;
  String _searchQuery = ''; // Guardará o texto da busca

  @override
  void initState() {
    super.initState();
    _pokemonsFuture = _api.fetchPokemons(limit: 50);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE53935),
      body: SafeArea(
        child: Column(
          children: [
            /// Cabeçalho
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

            /// Busca
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase().trim();
                  });
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

            /// Lista
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xffF5F5F5),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: FutureBuilder<List<Pokemon>>(
                  future: _pokemonsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Erro: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('Nenhum Pokémon encontrado.'));
                    }

                    // Pega a lista toda
                    final allPokemons = snapshot.data!;
                    
                    // Filtra de acordo com o que foi digitado
                    final pokemons = _searchQuery.isEmpty
                        ? allPokemons
                        : allPokemons.where((p) {
                            return p.name.toLowerCase().contains(_searchQuery) ||
                                   p.id.toString() == _searchQuery;
                          }).toList();

                    if (pokemons.isEmpty) {
                      return const Center(
                        child: Text(
                          'Nenhum Pokémon encontrado para essa busca.',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      );
                    }

                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10, // Espaçamento reduzido
                        mainAxisSpacing: 12, // Espaçamento reduzido
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