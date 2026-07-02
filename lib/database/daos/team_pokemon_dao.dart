import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/team_pokemon_table.dart';

part 'team_pokemon_dao.g.dart';

@DriftAccessor(tables: [TeamPokemons])
class TeamPokemonDao extends DatabaseAccessor<AppDatabase> with _$TeamPokemonDaoMixin {
  TeamPokemonDao(super.db);

  /// Adiciona um Pokémon ao time.
  Future<int> addPokemonToTeam(TeamPokemonsCompanion entry) {
    return into(teamPokemons).insert(entry);
  }

  /// Lista os Pokémons de um time.
  Future<List<TeamPokemon>> getPokemonsByTeam(int teamId) {
    return (select(teamPokemons)
          ..where((t) => t.teamId.equals(teamId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.pokemonId, mode: OrderingMode.asc),
          ]))
        .get();
  }

  /// Verifica se um Pokémon já pertence ao time.
  Future<bool> isPokemonInTeam(int teamId, int pokemonId) async {
    final pokemon = await (select(teamPokemons)
          ..where((t) => t.teamId.equals(teamId) & t.pokemonId.equals(pokemonId)))
        .getSingleOrNull();
    return pokemon != null;
  }

  /// Troca um Pokémon do time por outro.
  Future<void> replacePokemonInTeam(int teamId, int oldPokemonId, int newPokemonId) async {
    await transaction(() async {
      await removePokemonFromTeam(teamId, oldPokemonId);
      await addPokemonToTeam(
        TeamPokemonsCompanion(
          teamId: Value(teamId),
          pokemonId: Value(newPokemonId),
        ),
      );
    });
  }

  /// Remove um Pokémon específico de um time.
  Future<int> removePokemonFromTeam(int teamId, int pokemonId) {
    return (delete(teamPokemons)
          ..where((t) => t.teamId.equals(teamId) & t.pokemonId.equals(pokemonId)))
        .go();
  }

  /// Remove todos os Pokémons de um time.
  Future<int> clearTeam(int teamId) {
    return (delete(teamPokemons)..where((t) => t.teamId.equals(teamId))).go();
  }
}
