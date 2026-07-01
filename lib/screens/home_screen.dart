import 'package:flutter/material.dart';
import 'package:pokedex/wigdets/pokemon_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(decoration: InputDecoration(hintText: 'Buscar Pokémon')),
          Expanded(
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return PokemonCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}
