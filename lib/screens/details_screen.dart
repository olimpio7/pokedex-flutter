import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/models/pokemon.dart';
import '../widgets/type_color.dart';
import '../blocs/favorites/favorites_bloc.dart';
import '../blocs/favorites/favorites_event.dart';
import '../blocs/favorites/favorites_state.dart';

class DetailsScreen extends StatelessWidget {
  final Pokemon pokemon;
  
  const DetailsScreen({super.key, required this.pokemon});

  void saveFavorite(BuildContext context) {
    final pokemonToSave = Pokemon(
      id: pokemon.id,
      name: pokemon.name,
      image: pokemon.image,
      type: pokemon.type,
      height: pokemon.height,
      weight: pokemon.weight,
      comment: null,
      rating: null,
    );

    context.read<FavoritesBloc>().add(AddFavoriteEvent(pokemonToSave));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoritesBloc, FavoritesState>(
      listener: (context, state) {
        if (state is FavoritesError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message.replaceAll('Exception: ', '')))
          );
        } else if (state is FavoriteAdded) {
          if (Navigator.canPop(context)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Adicionado aos favoritos!'))
            );
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFE53935),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Detalhes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Hero(
                          tag: pokemon.id,
                          child: Image.network(
                            pokemon.image,
                            height: 180,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.catching_pokemon, color: Colors.grey, size: 100),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Text(
                          pokemon.name.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: typeColor(pokemon.type),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            pokemon.type ?? 'Unknown',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Altura',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                Text(
                                  pokemon.height != null
                                      ? "${(pokemon.height! % 10 == 0) ? (pokemon.height! ~/ 10).toString() : (pokemon.height! / 10).toStringAsFixed(1)} m"
                                      : "-",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Peso',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                                ),
                                Text(
                                  pokemon.weight != null
                                      ? "${(pokemon.weight! % 10 == 0) ? (pokemon.weight! ~/ 10).toString() : (pokemon.weight! / 10).toStringAsFixed(1)} kg"
                                      : "-",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),

                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => saveFavorite(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              padding: const EdgeInsets.all(16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: const Text(
                              'Adicionar aos Favoritos',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
