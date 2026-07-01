import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/favorite_table.dart';
import 'daos/favorite_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [Favorites], daos: [FavoriteDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'pokedex.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
