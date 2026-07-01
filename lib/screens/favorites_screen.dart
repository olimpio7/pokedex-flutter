import 'package:flutter/material.dart';
import 'package:pokedex/wigdets/favorite_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return FavoriteCard();
        },
      ),
    );
  }
}
