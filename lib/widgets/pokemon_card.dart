import 'package:flutter/material.dart';
import 'package:pokedex/screens/details_screen.dart';

class PokemonCard extends StatelessWidget {
  final String name;
  final String type;
  final String imageUrl;

  const PokemonCard({
    super.key,
    required this.name,
    required this.type,
    required this.imageUrl,
  });

  Color getTypeColor() {
    switch (type.toLowerCase()) {
      case 'grass':
        return Colors.green;
      case 'fire':
        return Colors.red;
      case 'water':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const DetailsScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: getTypeColor(),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(type, style: const TextStyle(color: Colors.white)),
              ],
            ),
            Image.network(imageUrl, height: 80),
          ],
        ),
      ),
    );
  }
}
