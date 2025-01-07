import 'package:flutter/material.dart';
import 'package:mis_lab_2/services/api_services.dart';
import 'package:mis_lab_2/widgets/joke_card.dart';

class JokesListScreen extends StatefulWidget {
  final String type;

  const JokesListScreen({super.key, required this.type});

  @override
  _JokesListScreenState createState() => _JokesListScreenState();
}

class _JokesListScreenState extends State<JokesListScreen> {
  late Future<List<Map<String, dynamic>>> jokes;

  @override
  void initState() {
    super.initState();
    jokes = fetchJokes(widget.type);
  }

  Future<List<Map<String, dynamic>>> fetchJokes(String type) async {
    return await ApiService.fetchJokesByType(type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jokes: ${widget.type}'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>( 
        future: jokes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No jokes available.'));
          }

          final jokesList = snapshot.data!;

          return ListView.builder(
            itemCount: jokesList.length,
            itemBuilder: (context, index) {
              final joke = jokesList[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: IntrinsicWidth( 
                  child: JokeCard(
                    setup: joke['setup'] ?? '',
                    punchline: joke['punchline'] ?? '',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

