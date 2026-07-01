import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalhes')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Image.network(
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
              height: 150,
            ),
            Text('Bulbasaur'),
            Text('Tipo: Grass'),
            Text('Altura: 7'),
            Text('Peso: 69'),

            SizedBox(height: 20),

            TextField(decoration: InputDecoration(labelText: 'Nota (1-5)')),

            TextField(decoration: InputDecoration(labelText: 'Comentário')),

            SizedBox(height: 20),

            ElevatedButton(onPressed: () {}, child: Text('Salvar Favorito')),
          ],
        ),
      ),
    );
  }
}
