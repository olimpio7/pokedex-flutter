import 'package:drift/drift.dart';

import '../database/app_database.dart';

class TeamRepository {
  final AppDatabase _db;

  TeamRepository(this._db);

  /// Cria um novo time.
  Future<int> createTeam({
    required String name,
    required String description,
    DateTime? createdAt,
  }) {
    final companion = TeamsCompanion(
      name: Value(name),
      description: Value(description),
      createdAt: Value(createdAt ?? DateTime.now()),
    );

    return _db.teamDao.createTeam(companion);
  }

  /// Busca todos os times cadastrados.
  Future<List<Team>> getTeams() {
    return _db.teamDao.getTeams();
  }

  /// Busca um time pelo ID.
  Future<Team?> getTeamById(int teamId) {
    return _db.teamDao.getTeamById(teamId);
  }

  /// Atualiza os dados de um time.
  Future<int> updateTeam({
    required int teamId,
    required String name,
    required String description,
    required DateTime createdAt,
  }) {
    final companion = TeamsCompanion(
      name: Value(name),
      description: Value(description),
      createdAt: Value(createdAt),
    );

    return _db.teamDao.updateTeam(teamId, companion);
  }

  /// Exclui um time pelo ID.
  Future<int> deleteTeam(int teamId) {
    return _db.teamDao.deleteTeam(teamId);
  }
}
