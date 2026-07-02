import 'package:flutter/material.dart';
import 'package:pokedex/models/pokemon.dart';
import '../main.dart';
import '../widgets/type_color.dart';

class DetailsScreen extends StatefulWidget {
  final Pokemon pokemon;
  
  const DetailsScreen({super.key, required this.pokemon});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Future<void> saveFavorite() async {
    final pokemonToSave = Pokemon(
      id: widget.pokemon.id,
      name: widget.pokemon.name,
      image: widget.pokemon.image,
      type: widget.pokemon.type,
      height: widget.pokemon.height,
      weight: widget.pokemon.weight,
      comment: null,
      rating: null,
    );

    try {
      await favoriteRepository.saveFavorite(pokemonToSave);
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Adicionado aos favoritos!')),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
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
                      Hero(
                        tag: widget.pokemon.id,
                        child: Image.network(
                          widget.pokemon.image,
                          height: 180,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        widget.pokemon.name.toUpperCase(),
                        style: const TextStyle(
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
                          color: typeColor(widget.pokemon.type),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.pokemon.type ?? 'Unknown',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              const Text(
                                'Altura',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                widget.pokemon.height != null
                                    ? "${(widget.pokemon.height! / 10).toStringAsFixed(1)} m"
                                    : "-",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const Text(
                                'Peso',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                widget.pokemon.weight != null
                                    ? "${(widget.pokemon.weight! / 10).toStringAsFixed(1)} kg"
                                    : "-",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: saveFavorite,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.all(16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text(
                            'Adicionar aos Favoritos',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
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
