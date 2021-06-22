import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';
import 'package:untitled/data/model/movie.dart';
import 'package:untitled/data/source/remote/repository/movie_repository.dart';
import 'package:untitled/data/source/remote/response/error_response.dart';

class TvBloc {
  final Stream<Tuple2<List<Movie>, List<Movie>>> dataList;

  TvBloc._({required this.dataList});

  factory TvBloc(MovieRepository movieRepository) {
    final nowMoveListStream =
        Rx.fromCallable(() => movieRepository.getMovieList(6, 1))
            .onErrorReturn([]);

    final popularMoveListStream =
        Rx.fromCallable(() => movieRepository.getMovieList(7, 1))
            .onErrorReturn([]);

    final dataList = Rx.zip2(nowMoveListStream, popularMoveListStream,
            (List<Movie> a, List<Movie> b) => Tuple2(a, b))
        .doOnError((error, stacktrace) {
      if (error is AppError) {
        print('doOnError: ' + error.message);
      }
      print(stacktrace);
    });

    return TvBloc._(dataList: dataList);
  }
}
