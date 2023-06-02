import "package:uuid/uuid.dart";

class Joke {
  final int id;
  final String setup;
  final String punchline;
  bool isFavorite;

  Joke({
    required this.id,
    required this.setup,
    required this.punchline,
    this.isFavorite = false,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      id: json['id'] ?? 0,
      setup: json['setup'] ?? json['joke'] ?? '',
      punchline: json['punchline'] ?? '',
    );
  }
}

