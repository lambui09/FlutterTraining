import 'package:untitled/data/model/movie.dart';
import 'package:untitled/data/source/remote/repository/base_repository.dart';

class MovieResponse {
  final int id;
  final String title;
  final String posterUrl;
  final String backdropUrl;
  final String voteAverage;

  MovieResponse(
      {required this.id,
      required this.title,
      required this.posterUrl,
      required this.backdropUrl,
      required this.voteAverage});

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        id: (jsonDecode(json, "id") as num).toInt(),
        title: jsonDecode(json, "title"),
        posterUrl: KeyPrams.imgPath + jsonDecode(json, "poster_path"),
        backdropUrl: KeyPrams.imgPath + jsonDecode(json, 'backdrop_path'),
        voteAverage: (jsonDecode(json, 'vote_average') as num).toString(),
      );

  Movie toMovie() {
    return Movie(this.id, this.title, this.posterUrl, this.backdropUrl,
        this.voteAverage);
  }
}
