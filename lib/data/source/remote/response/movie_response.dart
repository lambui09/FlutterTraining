import 'package:untitled/data/model/movie.dart';
import 'package:untitled/data/source/remote/repository/base_repository.dart';

class MovieResponse {
  final int id;
  final String title;
  final String posterUrl;
  final String backdropUrl;
  final String voteAverage;
  final String overview;
  final String releaseDate;
  final int voteCount;

  MovieResponse({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.backdropUrl,
    required this.voteAverage,
    required this.overview,
    required this.releaseDate,
    required this.voteCount,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) => MovieResponse(
        id: (jsonDecode(json, "id") as num).toInt(),
        title: jsonDecode(json, "title"),
        posterUrl: KeyPrams.imgPath + jsonDecode(json, "poster_path"),
        backdropUrl: KeyPrams.imgPath + jsonDecode(json, 'backdrop_path'),
        voteAverage: (jsonDecode(json, 'vote_average') as num).toString(),
        overview: jsonDecode(json, "overview"),
        releaseDate: jsonDecode(json, "release_date"),
        voteCount: jsonDecode(json, "vote_count"),
      );

  Movie toMovie() {
    return Movie(this.id, this.title, this.posterUrl, this.backdropUrl,
        this.voteAverage, this.overview, this.releaseDate, this.voteCount);
  }
}
