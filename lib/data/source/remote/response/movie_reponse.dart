import 'dart:convert';

import 'package:untitled/data/model/movie.dart';

class MovieResponse {
  final String id;
  final String title;
  final String posterUrl;

  MovieResponse({
    required this.id,
    required this.title,
    required this.posterUrl,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        id: json["media_type"],
        title: json["title"],
        posterUrl: json["poster_path"],
      );

  Movie toMovie() {
    return Movie(this.id, this.title, "https://image.tmdb.org/t/p/w500/" + this.posterUrl);
  }
}
