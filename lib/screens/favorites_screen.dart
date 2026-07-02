import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/widgets/favorite_card.dart';
import 'package:pokedex/models/pokemon.dart';
import '../blocs/favorites/favorites_bloc.dart';
import '../blocs/favorites/favorites_event.dart';
import '../blocs/favorites/favorites_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  void _deleteFavorite(BuildContext context, int id) {
    context.read<FavoritesBloc>().add(DeleteFavoriteEvent(id));
  }

  void _editFavorite(BuildContext context, Pokemon pokemon) {
    final ratingController = TextEditingController(text: pokemon.rating?.toString() ?? '');
    final commentController = TextEditingController(text: pokemon.comment ?? '');

    showDialog(
      context: context,
      builder: (dialogContext) {
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
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final rating = int.tryParse(ratingController.text);
                final comment = commentController.text;
                
                context.read<FavoritesBloc>().add(
                  EditFavoriteEvent(
                    pokemonId: pokemon.id,
                    comment: comment,
                    rating: rating,
                  ),
                );
                Navigator.pop(dialogContext);
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
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            if (state is FavoritesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FavoritesError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              );
            } else if (state is FavoritesLoaded) {
              final favorites = state.favorites;
              if (favorites.isEmpty) {
                return const Center(
                  child: Text(
                    'Nenhum Pokémon favoritado ainda.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final pokemon = favorites[index];
                  return FavoriteCard(
                    pokemon: pokemon,
                    onEdit: () => _editFavorite(context, pokemon),
                    onDelete: () => _deleteFavorite(context, pokemon.id),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
