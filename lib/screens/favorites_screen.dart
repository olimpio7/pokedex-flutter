import 'package:flutter/material.dart';
import 'package:pokedex/widgets/favorite_card.dart';
import 'package:pokedex/models/pokemon.dart';

import '../main.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Pokemon> favorites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final list = await favoriteRepository.getAllFavorites();
    setState(() {
      favorites = list;
      isLoading = false;
    });
  }

  Future<void> _deleteFavorite(int id) async {
    await favoriteRepository.removeFavorite(id);
    _loadFavorites();
  }

  Future<void> _editFavorite(Pokemon pokemon) async {
    final ratingController = TextEditingController(text: pokemon.rating?.toString() ?? '');
    final commentController = TextEditingController(text: pokemon.comment ?? '');

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar ${pokemon.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: ratingController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Nota (0 a 5)',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: commentController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Comentário',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final rating = int.tryParse(ratingController.text);
                final comment = commentController.text;
                final nav = Navigator.of(context);
                await favoriteRepository.updateFavoriteCommentAndRating(pokemon.id, comment, rating);
                nav.pop();
                _loadFavorites();
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE53935),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE53935),
        elevation: 0,
        title: const Text('Favoritos', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : favorites.isEmpty
                ? const Center(
                    child: Text(
                      'Nenhum Pokémon favoritado ainda.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: favorites.length,
                    itemBuilder: (context, index) {
                      final pokemon = favorites[index];
                      return FavoriteCard(
                        pokemon: pokemon,
                        onEdit: () => _editFavorite(pokemon),
                        onDelete: () => _deleteFavorite(pokemon.id),
                      );
                    },
                  ),
      ),
    );
  }
}
