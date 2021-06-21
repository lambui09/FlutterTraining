import 'package:untitled/data/model/movie.dart';
import 'package:untitled/data/source/remote/AppClient.dart';
import 'package:untitled/data/source/remote/repository/base_repository.dart';
import 'package:untitled/data/source/remote/response/movie_reponse.dart';

abstract class MovieRepository {
  Future<List<Movie>> getMovieList(int movieId, int page);
}

class MovieRepositoryImpl extends BaseRepository implements MovieRepository {
  final ApiService _apiService;

  MovieRepositoryImpl(this._apiService);

  @override
  Future<List<Movie>> getMovieList(int movieId, int page) async {
    try {
      print("getMovieList");
      Uri uri = createUri('/4/list/$movieId',
          {'page': '$page', 'api_key': 'c29a024e152bfd1ad3d4d0dc8cb48019'});

      //   Uri uri = Uri.parse("https://api.themoviedb.org/3/list/1?api_key=c29a024e152bfd1ad3d4d0dc8cb48019");
      print('$uri');

      final results = await _apiService.getItem(uri);
      final data = results['results'] as List;
      print("data: $data");

      return data
          .map((item) => MovieResponse.fromJson(item).toMovie())
          .toList();
    } catch (e) {
      print("errror");
      print(e.toString());
      rethrow;
    }
  }
}
