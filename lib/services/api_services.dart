import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = "https://official-joke-api.appspot.com";

  static Future<List<String>> fetchJokeTypes() async {
    final response = await http.get(Uri.parse("$baseUrl/types"));
    return List<String>.from(json.decode(response.body));
  }

  static Future<List<Map<String, dynamic>>> fetchJokesByType(String type) async {
    final response = await http.get(Uri.parse("$baseUrl/jokes/$type/ten"));
    return List<Map<String, dynamic>>.from(json.decode(response.body));
  }

  static Future<Map<String, dynamic>> fetchRandomJoke() async {
    final response = await http.get(Uri.parse("$baseUrl/random_joke"));
    return json.decode(response.body);
  }
}