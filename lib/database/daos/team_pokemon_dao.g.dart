// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_pokemon_dao.dart';

// ignore_for_file: type=lint
mixin _$TeamPokemonDaoMixin on DatabaseAccessor<AppDatabase> {
  $TeamPokemonsTable get teamPokemons => attachedDatabase.teamPokemons;
  TeamPokemonDaoManager get managers => TeamPokemonDaoManager(this);
}

class TeamPokemonDaoManager {
  final _$TeamPokemonDaoMixin _db;
  TeamPokemonDaoManager(this._db);
  $$TeamPokemonsTableTableManager get teamPokemons =>
      $$TeamPokemonsTableTableManager(_db.attachedDatabase, _db.teamPokemons);
}
