import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/favorite_table.dart';

part 'favorite_dao.g.dart';

@DriftAccessor(tables: [Favorites])
class FavoriteDao extends DatabaseAccessor<AppDatabase> with _$FavoriteDaoMixin {
  FavoriteDao(super.db);

  // Criar: Adiciona um pokemon aos favoritos (falha se já existir, garantindo integridade)
  Future<int> addFavorite(FavoritesCompanion entry) {
    return into(favorites).insert(entry);
  }

  // Ler (Todos): Pega a lista completa de favoritos salvos, ordenada pelo ID numérico
  Future<List<Favorite>> getFavorites() {
    return (select(favorites)
          ..orderBy([
            (t) => OrderingTerm(expression: t.pokemonId, mode: OrderingMode.asc)
          ]))
        .get();
  }

  // Ler (Um só): Busca por um id específico para saber se é favorito
  Future<Favorite?> getFavoriteByPokemonId(int pokemonId) {
    return (select(favorites)..where((t) => t.pokemonId.equals(pokemonId))).getSingleOrNull();
  }

  //Modifica apenas os campos de comentário e nota
  Future<int> updateFavoriteCommentAndRating(int pokemonId, String? newComment, int? newRating) {
    return (update(favorites)..where((t) => t.pokemonId.equals(pokemonId))).write(
      FavoritesCompanion(
        comment: Value(newComment),
        rating: Value(newRating),
      ),
    );
  }

  // Deletar: Remove o pokemon dos favoritos pelo ID
  Future<int> removeFavorite(int pokemonId) {
    return (delete(favorites)..where((t) => t.pokemonId.equals(pokemonId))).go();
  }
}
