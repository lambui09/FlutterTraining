import 'package:rxdart/rxdart.dart';
import 'package:untitled/data/model/movie.dart';
import 'package:untitled/data/source/remote/repository/movie_repository.dart';

class MovieBloc {
  final Stream<List<Movie>> sliderMovieList;
  final Stream<List<Movie>> nowMovieList;
  final Stream<List<Movie>> popularMovieList;

  MovieBloc._(
      {required this.sliderMovieList,
      required this.nowMovieList,
      required this.popularMovieList});

  factory MovieBloc(MovieRepository movieRepository) {
    final sliderMoveListStream =
        Rx.fromCallable(() => movieRepository.getMovieList(3, 1));

    final nowMoveListStream =
        Rx.fromCallable(() => movieRepository.getMovieList(1, 1));

    final popularMoveListStream =
        Rx.fromCallable(() => movieRepository.getMovieList(2, 1));

    final streams = [
      sliderMoveListStream,
      nowMoveListStream,
      popularMoveListStream
    ];
    return MovieBloc._(
        sliderMovieList: sliderMoveListStream,
        nowMovieList: nowMoveListStream,
        popularMovieList: popularMoveListStream);
  }
}
