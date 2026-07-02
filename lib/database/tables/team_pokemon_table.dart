import 'package:drift/drift.dart';

class TeamPokemons extends Table {
  IntColumn get teamId => integer()();
  IntColumn get pokemonId => integer()();

  @override
  Set<Column> get primaryKey => {teamId, pokemonId};
}
