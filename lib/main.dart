import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/trainer/trainer_bloc.dart';
import 'blocs/trainer/trainer_event.dart';
import 'blocs/teams/teams_bloc.dart';
import 'blocs/teams/teams_event.dart';
import 'blocs/home/home_bloc.dart';
import 'blocs/home/home_event.dart';
import 'blocs/favorites/favorites_bloc.dart';
import 'blocs/favorites/favorites_event.dart';
import 'package:pokedex/screens/home_screen.dart';
import 'database/app_database.dart';
import 'repositories/poke_api_repository.dart';
import 'repositories/favorite_repository.dart';
import 'repositories/team_repository.dart';
import 'repositories/team_pokemon_repository.dart';
import 'repositories/trainer_repository.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(database: AppDatabase()));
}

class MyApp extends StatelessWidget {
  final AppDatabase database;
  const MyApp({super.key, required this.database});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FavoriteRepository>(create: (_) => FavoriteRepository(database)),
        RepositoryProvider<TeamRepository>(create: (_) => TeamRepository(database)),
        RepositoryProvider<TeamPokemonRepository>(create: (_) => TeamPokemonRepository(database)),
        RepositoryProvider<TrainerRepository>(create: (_) => TrainerRepository(database)),
        RepositoryProvider<PokeApiRepository>(create: (_) => PokeApiRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TrainerBloc>(
            create: (context) => TrainerBloc(context.read<TrainerRepository>())..add(LoadTrainerEvent()),
          ),
          BlocProvider<TeamsBloc>(
            create: (context) => TeamsBloc(context.read<TeamRepository>())..add(LoadTeamsEvent()),
          ),
          BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(context.read<PokeApiRepository>())..add(LoadPokemonsEvent()),
          ),
          BlocProvider<FavoritesBloc>(
            create: (context) => FavoritesBloc(context.read<FavoriteRepository>())..add(LoadFavoritesEvent()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.red),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}
