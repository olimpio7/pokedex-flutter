import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/team_table.dart';

part 'team_dao.g.dart';

@DriftAccessor(tables: [Teams])
class TeamDao extends DatabaseAccessor<AppDatabase> with _$TeamDaoMixin {
  TeamDao(super.db);

  Future<int> createTeam(TeamsCompanion entry) {
    return into(teams).insert(entry);
  }

  Future<List<Team>> getTeams() {
    return (select(teams)
          ..orderBy([
            (t) => OrderingTerm(expression: t.createdAt, mode: OrderingMode.desc),
          ]))
        .get();
  }

  Future<Team?> getTeamById(int teamId) {
    return (select(teams)..where((t) => t.teamId.equals(teamId))).getSingleOrNull();
  }

  Future<int> updateTeam(int teamId, TeamsCompanion entry) {
    return (update(teams)..where((t) => t.teamId.equals(teamId))).write(entry);
  }

  Future<int> deleteTeam(int teamId) {
    return (delete(teams)..where((t) => t.teamId.equals(teamId))).go();
  }
}
