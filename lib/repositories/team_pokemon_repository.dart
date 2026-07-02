import 'package:drift/drift.dart';

import '../database/app_database.dart';

class TeamPokemonRepository {
  final AppDatabase _db;

  TeamPokemonRepository(this._db);

  Future<int> addPokemonToTeam({
    required int teamId,
    required int pokemonId,
  }) {
    final companion = TeamPokemonsCompanion(
      teamId: Value(teamId),
      pokemonId: Value(pokemonId),
    );

    return _db.teamPokemonDao.addPokemonToTeam(companion);
  }

  Future<List<TeamPokemon>> getPokemonsByTeam(int teamId) {
    return _db.teamPokemonDao.getPokemonsByTeam(teamId);
  }

  Future<bool> isPokemonInTeam({
    required int teamId,
    required int pokemonId,
  }) {
    return _db.teamPokemonDao.isPokemonInTeam(teamId, pokemonId);
  }

  Future<void> replacePokemonInTeam({
    required int teamId,
    required int oldPokemonId,
    required int newPokemonId,
  }) {
    return _db.teamPokemonDao.replacePokemonInTeam(teamId, oldPokemonId, newPokemonId);
  }

  Future<int> removePokemonFromTeam({
    required int teamId,
    required int pokemonId,
  }) {
    return _db.teamPokemonDao.removePokemonFromTeam(teamId, pokemonId);
  }

  Future<int> clearTeam(int teamId) {
    return _db.teamPokemonDao.clearTeam(teamId);
  }
}
