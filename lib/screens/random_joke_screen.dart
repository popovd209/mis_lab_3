import 'package:flutter/material.dart';
import 'package:mis_lab_2/services/api_services.dart';
import 'package:mis_lab_2/widgets/joke_card.dart';

class RandomJokeScreen extends StatefulWidget {
  const RandomJokeScreen({super.key});

  @override
  _RandomJokeScreenState createState() => _RandomJokeScreenState();
}

class _RandomJokeScreenState extends State<RandomJokeScreen> {
  late Future<Map<String, dynamic>> randomJoke;

  @override
  void initState() {
    super.initState();
    randomJoke = fetchRandomJoke();
  }

  Future<Map<String, dynamic>> fetchRandomJoke() async {
    return await ApiService.fetchRandomJoke();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Joke'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: randomJoke,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: Text('No joke available.'));
          }

          final joke = snapshot.data!;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: JokeCard(
                setup: joke['setup'] ?? '',
                punchline: joke['punchline'] ?? '',
              ),
            ),
          );
        },
      ),
    );
  }
}
