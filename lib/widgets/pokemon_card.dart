import 'package:flutter/material.dart';

import '../models/pokemon.dart';
import 'info_chip.dart';
import 'type_color.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback? onTap;

  const PokemonCard({
    super.key,
    required this.pokemon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = typeColor(pokemon.type);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              color,
              color.withValues(alpha: .75),
            ],
          ),
          border: Border.all(
            color: const Color(0xffFFD54F),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: .35),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              /// Cabeçalho
              Row(
                children: [
                  Expanded(
                    child: Text(
                      pokemon.name.toUpperCase(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  Text(
                    "#${pokemon.id}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  )
                ],
              ),

              const SizedBox(height: 8),

              /// Imagem
              Expanded(
                child: Hero(
                  tag: pokemon.id,
                  child: Image.network(
                    pokemon.image,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              /// Tipo
              InfoChip(
                icon: Icons.catching_pokemon,
                text: pokemon.type ?? "Unknown",
              ),

              const SizedBox(height: 6),

              /// Altura e peso
              Row(
                children: [
                  Expanded(
                    child: InfoChip(
                      icon: Icons.height,
                      text: pokemon.height != null
                          ? "${(pokemon.height! % 10 == 0) ? (pokemon.height! ~/ 10).toString() : (pokemon.height! / 10).toStringAsFixed(1)} m"
                          : "- m",
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: InfoChip(
                      icon: Icons.monitor_weight_outlined,
                      text: pokemon.weight != null
                          ? "${(pokemon.weight! % 10 == 0) ? (pokemon.weight! ~/ 10).toString() : (pokemon.weight! / 10).toStringAsFixed(1)} kg"
                          : "- kg",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}