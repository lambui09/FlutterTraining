import 'package:untitled/data/model/movie.dart';
import 'package:untitled/data/source/remote/AppClient.dart';
import 'package:untitled/data/source/remote/repository/base_repository.dart';
import 'package:untitled/data/source/remote/response/movie_response.dart';

abstract class MovieRepository {
  Future<List<Movie>> getMovieList(int movieId, int page);

  Future<List<Movie>> searchMovie(String keyword, int page);
}

class MovieRepositoryImpl implements MovieRepository {
  final ApiService _apiService;

  MovieRepositoryImpl(this._apiService);

  @override
  Future<List<Movie>> getMovieList(int movieId, int page) async {
    Uri uri = createUri(KeyPrams.v4_list + '$movieId', {
      KeyPrams.page: '$page',
    });

    final results = await _apiService.getItem(uri);
    final data = results[KeyPrams.results] as List;
    return data.map((item) => MovieResponse.fromJson(item).toMovie()).toList();
  }

  @override
  Future<List<Movie>> searchMovie(String keyword, int page) async {
    Uri uri = createUri(KeyPrams.v3_search_movie, {
      KeyPrams.query: keyword,
      KeyPrams.page: '$page',
    });

    final results = await _apiService.getItem(uri);
    final data = results[KeyPrams.results] as List;
    return data.map((item) => MovieResponse.fromJson(item).toMovie()).toList();
  }
}
