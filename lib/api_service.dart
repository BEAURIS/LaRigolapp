import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'Joke.dart';

class ApiService {
  static int _retries = 3;
  static Duration _retryInterval = Duration(seconds: 1);

  static Future<Joke> fetchJoke(int id) async {
    int attempt = 0;
    while (attempt < _retries) {
      try {
        final response = await http.get(Uri.parse('https://v2.jokeapi.dev/joke/Any?lang=fr'));

        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          print(jsonResponse);
          String setup, punchline;

          if (jsonResponse['type'] == 'single') {
            setup = jsonResponse['joke'];
            punchline = '';
          } else if (jsonResponse['type'] == 'twopart') {
            setup = jsonResponse['setup'];
            punchline = jsonResponse['delivery'];
          } else {
            throw Exception('Erreur lors du traitement de la réponse : type de blague inconnu');
          }

          return Joke(id: id, setup: setup, punchline: punchline);
        } else {
          throw Exception('Erreur lors du chargement de la blague, code HTTP : ${response.statusCode}');
        }
      } catch (e) {
        attempt++;
        if (attempt == _retries) {
          throw e;
        }
        await Future.delayed(_retryInterval);
      }
    }
    throw Exception('Erreur lors du chargement de la blague');
  }
}
