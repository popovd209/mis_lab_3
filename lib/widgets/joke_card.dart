import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class JokeCard extends StatelessWidget {
  final String setup;
  final String punchline;

  const JokeCard({super.key, required this.setup, required this.punchline});

  Future<void> addToFavorites() async {
    final favorites = FirebaseFirestore.instance.collection('favorites');
    await favorites.add({'setup': setup, 'punchline': punchline});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              setup,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              punchline,
              style: TextStyle(
                fontSize: 14,
                fontStyle: FontStyle.italic,
                color: Colors.grey[700],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: addToFavorites,
              tooltip: 'Add to Favorites',
            ),
          ],
        ),
      ),
    );
  }
}
