import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import '../database/app_database.dart';
import '../models/pokemon.dart';

class FavoriteRepository {
  final AppDatabase _db;

  FavoriteRepository(this._db);

  Future<void> saveFavorite(Pokemon pokemon) async {

    if (await isFavorite(pokemon.id)) {
      throw Exception('Pokémon já existe nos favoritos.');
    }

    final companion = FavoritesCompanion(
      pokemonId: Value(pokemon.id),
      name: Value(pokemon.name),
      image: Value(pokemon.image),
      comment: Value(pokemon.comment),
      rating: Value(pokemon.rating),
    );
    await _db.favoriteDao.addFavorite(companion);
  }

  Future<List<Pokemon>> getAllFavorites() async {
    try {
      final favoriteList = await _db.favoriteDao.getFavorites();

      return favoriteList.map((f) => Pokemon(
        id: f.pokemonId,
        name: f.name,
        image: f.image,
        comment: f.comment,
        rating: f.rating,
      )).toList();
    } catch (error, stackTrace) {
      debugPrint('Erro ao carregar favoritos: $error');
      debugPrintStack(stackTrace: stackTrace);
      return [];
    }
  }

  Future<void> removeFavorite(int pokemonId) async {
    await _db.favoriteDao.removeFavorite(pokemonId);
  }

  Future<void> updateFavoriteCommentAndRating(int pokemonId, String? comment, int? rating) async {
    await _db.favoriteDao.updateFavoriteCommentAndRating(pokemonId, comment, rating);
  }

  Future<bool> isFavorite(int pokemonId) async {
    final favorite = await _db.favoriteDao.getFavoriteByPokemonId(pokemonId);
    return favorite != null;
  }
}
