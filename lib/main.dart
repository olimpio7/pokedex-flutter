import 'package:flutter/material.dart';
import 'package:pokedex/screens/home_screen.dart';
import 'database/app_database.dart';
import 'repositories/favorite_repository.dart';

import 'repositories/team_repository.dart';
import 'repositories/team_pokemon_repository.dart';
import 'repositories/trainer_repository.dart';

late final FavoriteRepository favoriteRepository;
late final TeamRepository teamRepository;
late final TeamPokemonRepository teamPokemonRepository;
late final TrainerRepository trainerRepository;

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();
  favoriteRepository = FavoriteRepository(database);
  teamRepository = TeamRepository(database);
  teamPokemonRepository = TeamPokemonRepository(database);
  trainerRepository = TrainerRepository(database);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.red),
      home: HomeScreen(),
    );
  }
}
