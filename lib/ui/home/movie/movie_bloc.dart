import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';
import 'package:untitled/data/model/movie.dart';
import 'package:untitled/data/source/remote/repository/movie_repository.dart';
import 'package:untitled/data/source/remote/response/error_response.dart';

class MovieBloc {
  final Stream<Tuple3<List<Movie>, List<Movie>, List<Movie>>> dataList;

  MovieBloc._({required this.dataList});

  factory MovieBloc(MovieRepository movieRepository) {
    final sliderMoveListStream =
        Rx.fromCallable(() => movieRepository.getMovieList(3, 1));

    final nowMoveListStream =
        Rx.fromCallable(() => movieRepository.getMovieList(1, 1));

    final popularMoveListStream =
        Rx.fromCallable(() => movieRepository.getMovieList(4, 1))
            .onErrorReturn([]);

    final dataList = Rx.zip3(
            sliderMoveListStream,
            nowMoveListStream,
            popularMoveListStream,
            (List<Movie> a, List<Movie> b, List<Movie> c) => Tuple3(a, b, c))
        .doOnError((err, stacktrace) {
      if (err is AppError) {
        print('doOnError: ' + err.message);
      }
      print(stacktrace);
    });

    return MovieBloc._(dataList: dataList);
  }
}
