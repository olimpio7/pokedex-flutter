import 'package:drift/drift.dart';

import '../database/app_database.dart';

class TeamRepository {
  final AppDatabase _db;

  TeamRepository(this._db);

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

  Future<List<Team>> getTeams() {
    return _db.teamDao.getTeams();
  }

  Future<Team?> getTeamById(int teamId) {
    return _db.teamDao.getTeamById(teamId);
  }

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

  Future<int> deleteTeam(int teamId) {
    return _db.teamDao.deleteTeam(teamId);
  }
}
