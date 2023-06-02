import 'package:flutter/material.dart';
import 'Joke.dart';
import 'api_service.dart';

class JokeProvider with ChangeNotifier {
  List<Joke> _jokes = [];
  List<Joke> _favorites = [];

  List<Joke> get jokes => _jokes;
  List<Joke> get favorites => _favorites;

  Future<void> fetchJokes({required int offset}) async {
    for (int i = 0; i < 20; i++) {
      Joke joke = await ApiService.fetchJoke(i);
      _jokes.add(joke);
      notifyListeners();
    }
  }

  void addToFavorites(Joke joke) {
    _favorites.add(joke);
    joke.isFavorite = true;
    notifyListeners();
  }

  void removeFromFavorites(Joke joke) {
    _favorites.remove(joke);
    joke.isFavorite = false;
    notifyListeners();
  }

  void setJokeType(String selectedType) {}

  Future<void> fetchJoke({int offset = 0}) async {
    List<Joke> fetchedJokes = [];
    for (int i = offset; i < offset + 20; i++) {
      Joke joke = await ApiService.fetchJoke(i);
      fetchedJokes.add(joke);
    }
    _jokes = fetchedJokes;
    notifyListeners();
  }

}