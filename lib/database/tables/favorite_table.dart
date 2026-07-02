import 'package:drift/drift.dart';

class Favorites extends Table {
  IntColumn get pokemonId => integer()();
  TextColumn get name => text()();
  TextColumn get image => text()();
  TextColumn get comment => text().nullable()();
  IntColumn get rating => integer().nullable()();

  @override
  Set<Column> get primaryKey => {pokemonId};
}
