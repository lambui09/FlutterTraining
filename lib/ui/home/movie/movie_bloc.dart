import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';
import 'package:untitled/base/base_bloc.dart';
import 'package:untitled/data/model/movie.dart';
import 'package:untitled/data/source/remote/repository/movie_repository.dart';

class MovieBloc extends BaseBloc<EmptyState> {
  final Sink<void> loadData;
  final Stream<Tuple3<List<Movie>, List<Movie>, List<Movie>>> dataList;

  MovieBloc._({required this.dataList, required this.loadData})
      : super(EmptyState());

  factory MovieBloc(MovieRepository movieRepository) {
    // ignore: close_sinks
    final loadData = BehaviorSubject<void>.seeded(0);

    final sliderMoveListStream =
        Rx.fromCallable(() => movieRepository.getMovieList(3, 1));

    final nowMoveListStream =
        Rx.fromCallable(() => movieRepository.getMovieList(1, 1));

    final popularMoveListStream =
        Rx.fromCallable(() => movieRepository.getMovieList(5, 1))
            .onErrorReturn([]);

    final dataList = loadData.flatMap((value) => Rx.zip3(
        sliderMoveListStream,
        nowMoveListStream,
        popularMoveListStream,
        (List<Movie> a, List<Movie> b, List<Movie> c) => Tuple3(a, b, c)));

    return MovieBloc._(dataList: dataList, loadData: loadData);
  }

  @override
  void dispose() {
    loadData.close();
  }
}
