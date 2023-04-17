import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Joke.dart';

class ApiService {
  static Future<Joke> fetchJoke() async {
    final response = await http.get(Uri.parse('https://sv443.net/jokeapi/v2/joke/Any?lang=fr'));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return Joke(setup: jsonResponse['setup'], punchline: jsonResponse['delivery']);
    } else {
      throw Exception('Erreur lors du chargement de la blague');
    }
  }
}
