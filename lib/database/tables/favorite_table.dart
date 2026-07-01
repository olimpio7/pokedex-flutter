import 'package:drift/drift.dart';

class Favorites extends Table {
  IntColumn get pokemonId => integer()();
  TextColumn get name => text()();
  TextColumn get image => text()();
  TextColumn get comment => text().nullable()();
  IntColumn get rating => integer().nullable()(); // Nota de 1 a 5

  @override
  Set<Column> get primaryKey => {pokemonId};
}
