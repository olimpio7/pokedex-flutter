import 'package:flutter/material.dart';
import 'package:pokedex/screens/details_screen.dart';
import 'package:pokedex/screens/favorites_screen.dart';
import 'package:pokedex/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/details': (context) => DetailsScreen(),
        '/favorites': (context) => FavoritesScreen(),
      },
    );
  }
}
