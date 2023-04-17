import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'api_service.dart';
import 'joke_provider.dart';
import 'Joke.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Joke _joke;

  @override
  void initState() {
    super.initState();
    fetchJoke();
  }

  void fetchJoke() async {
    _joke = (await ApiService.fetchJoke()) as Joke;
    setState(() {});
  }

void showAddedToFavoritesDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text("Ajouté aux favoris"),
        content: Text("Ta blague a été ajoutée à tes favoris !"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("OK"),
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    final jokeProvider = Provider.of<JokeProvider>(context);
    return Scaffold(
      backgroundColor: Colors.purple.shade50,
      body: _joke == null
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          children: [
                            Text(_joke.setup,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple.shade700,
                                ),
                                textAlign: TextAlign.center),
                            SizedBox(height: 12),
                            Text(_joke.punchline,
                                style: TextStyle(fontSize: 18),
                                textAlign: TextAlign.center),
                            SizedBox(height: 12),
                            IconButton(
                              icon: Icon(
                                _joke.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                              ),
                              onPressed: () {
  if (_joke.isFavorite) {
    jokeProvider.removeFromFavorites(_joke);
  } else {
    jokeProvider.addToFavorites(_joke);
    showAddedToFavoritesDialog(context);
  }
  setState(() {});
},

                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: fetchJoke,
                      child: Text('UNE BLAGUE ARNO !'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple.shade700,
                        padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                        textStyle: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
