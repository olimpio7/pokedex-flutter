import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/favorite_table.dart';

part 'favorite_dao.g.dart';

@DriftAccessor(tables: [Favorites])
class FavoriteDao extends DatabaseAccessor<AppDatabase> with _$FavoriteDaoMixin {
  FavoriteDao(super.db);

  Future<int> addFavorite(FavoritesCompanion entry) {
    return into(favorites).insert(entry);
  }

  Future<List<Favorite>> getFavorites() {
    return (select(favorites)
          ..orderBy([
            (t) => OrderingTerm(expression: t.pokemonId, mode: OrderingMode.asc)
          ]))
        .get();
  }

  Future<Favorite?> getFavoriteByPokemonId(int pokemonId) {
    return (select(favorites)..where((t) => t.pokemonId.equals(pokemonId))).getSingleOrNull();
  }

  Future<int> updateFavoriteCommentAndRating(int pokemonId, String? newComment, int? newRating) {
    return (update(favorites)..where((t) => t.pokemonId.equals(pokemonId))).write(
      FavoritesCompanion(
        comment: Value(newComment),
        rating: Value(newRating),
      ),
    );
  }

  Future<int> removeFavorite(int pokemonId) {
    return (delete(favorites)..where((t) => t.pokemonId.equals(pokemonId))).go();
  }
}
