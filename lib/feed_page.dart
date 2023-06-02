import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'joke_provider.dart';
import 'Joke.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({Key? key}) : super(key: key);

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> with TickerProviderStateMixin {
  late ScrollController _scrollController;
  final List<AnimationController> _animations = [];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    Provider.of<JokeProvider>(context, listen: false).fetchJoke();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    for (final animation in _animations) {
      animation.dispose();
    }
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        Provider.of<JokeProvider>(context, listen: false)
            .fetchJoke()
            .then((_) {
          setState(() {});
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final jokeProvider = Provider.of<JokeProvider>(context);

    while (_animations.length < jokeProvider.jokes.length) {
      _animations.add(
        AnimationController(
          vsync: this,
          duration: Duration(milliseconds: 300),
        )..forward(),
      );
    }

    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      body: jokeProvider.jokes.isEmpty
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async {
                await jokeProvider.fetchJoke();
                setState(() {});
              },
              child: ListView.builder(
                controller: _scrollController,
                itemCount: jokeProvider.jokes.length,
                itemBuilder: (context, index) {
                  Joke joke = jokeProvider.jokes[index];
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0, 1),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: _animations[index],
                        curve: Curves.easeOut,
                      ),
                    ),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      child: Padding(
                        padding: EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              joke.setup,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple.shade800,
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              joke.punchline,
                              style: TextStyle(fontSize: 18),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    joke.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    if (joke.isFavorite) {
                                      jokeProvider.removeFromFavorites(joke);
                                    } else {
                                      jokeProvider.addToFavorites(joke);
                                      _showAddedToFavoritesDialog(context);
                                    }
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }

  void _showAddedToFavoritesDialog(BuildContext context) {
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
}
