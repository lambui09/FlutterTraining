import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';
import 'package:untitled/base/base_bloc.dart';
import 'package:untitled/data/model/movie.dart';
import 'package:untitled/data/source/remote/repository/movie_repository.dart';
import 'package:untitled/data/source/remote/response/error_response.dart';

class TvBloc extends BaseBloc<EmptyState> {
  final Stream<Tuple2<List<Movie>, List<Movie>>> dataList;

  TvBloc._({required this.dataList}) : super(EmptyState());

  factory TvBloc(MovieRepository movieRepository) {
    final nowMoveListStream = Rx.fromCallable(
            () => movieRepository.getMovieList(MovieTypeStatus.tvNow))
        .onErrorReturn([]);

    final popularMoveListStream = Rx.fromCallable(
            () => movieRepository.getMovieList(MovieTypeStatus.tvPopular))
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

  @override
  void dispose() {}
}
