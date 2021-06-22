import 'package:untitled/data/model/movie.dart';
import 'package:untitled/data/source/remote/repository/base_repository.dart';

class MovieResponse {
  final String id;
  final String title;
  final String posterUrl;
  final String backdropUrl;

  MovieResponse({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        id: jsonDecode(json, "media_type"),
        title: jsonDecode(json, "title"),
        posterUrl: KeyPrams.imgPath + jsonDecode(json, "poster_path"),
        backdropUrl: KeyPrams.imgPath + jsonDecode(json, 'backdrop_path'),
      );

  Movie toMovie() {
    return Movie(this.id, this.title, this.posterUrl, this.backdropUrl);
  }
}
