import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import '../main.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final TextEditingController noteController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

  Future<void> saveFavorite() async {
    final rating = int.tryParse(noteController.text) ?? 0;
    final comment = commentController.text;

    final pokemon = Pokemon(
      id: 1, // depois vira dinâmico
      name: 'Bulbasaur',
      image:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      comment: comment,
      rating: rating,
    );

    try {
      await favoriteRepository.saveFavorite(pokemon);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Adicionado aos favoritos!')),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE53935),
      body: SafeArea(
        child: Column(
          children: [
            // topo
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    'Detalhes',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // conteúdo branco
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Image.network(
                        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
                        height: 180,
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Bulbasaur',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'Grass',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                'Altura',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('7'),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'Peso',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('69'),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      TextField(
                        controller: noteController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Nota (1 a 5)',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextField(
                        controller: commentController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Comentário',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: saveFavorite,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.all(16),
                          ),
                          child: const Text(
                            'Salvar Favorito',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
