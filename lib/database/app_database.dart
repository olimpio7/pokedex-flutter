import 'package:drift/drift.dart';

import 'tables/favorite_table.dart';
import 'tables/trainer_table.dart';
import 'tables/team_table.dart';
import 'tables/team_pokemon_table.dart';
import 'daos/favorite_dao.dart';
import 'daos/trainer_dao.dart';
import 'daos/team_dao.dart';
import 'daos/team_pokemon_dao.dart';
import 'native_connection.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Favorites,
    Trainers,
    Teams,
    TeamPokemons,
  ],
  daos: [
    FavoriteDao,
    TrainerDao,
    TeamDao,
    TeamPokemonDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 3) {
            await m.createTable(trainers);
            await m.createTable(teams);
            await m.createTable(teamPokemons);
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async => await openDatabaseConnection());
}
