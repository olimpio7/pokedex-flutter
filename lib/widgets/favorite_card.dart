import 'package:flutter/material.dart';
import '../models/pokemon.dart';

class FavoriteCard extends StatelessWidget {
  final Pokemon pokemon;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const FavoriteCard({
    super.key,
    required this.pokemon,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xffF5F5F5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  pokemon.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            
            const SizedBox(width: 16),
            

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pokemon.name.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 6),
                  

                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(
                        index < (pokemon.rating ?? 0)
                            ? Icons.star_rounded
                            : Icons.star_border_rounded,
                        color: Colors.amber,
                        size: 20,
                      ),
                    ),
                  ),
                  
                  if (pokemon.comment != null && pokemon.comment!.trim().isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Text(
                      pokemon.comment!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade700,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            
            Column(
              children: [
                IconButton(
                  onPressed: onEdit,
                  icon: const Icon(Icons.edit_note_rounded),
                  color: Colors.blue.shade400,
                  tooltip: 'Editar Nota e Comentário',
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: const Icon(Icons.delete_outline_rounded),
                  color: Colors.red.shade400,
                  tooltip: 'Remover Favorito',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}