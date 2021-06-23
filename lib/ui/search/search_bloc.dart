import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:untitled/data/source/remote/repository/movie_repository.dart';

import 'search_sate.dart';

class SearchBloc {
  final Sink<String> onTextChanged;
  final Stream<SearchState> state;

  factory SearchBloc(MovieRepository movieRepository) {
    // ignore: close_sinks
    final onTextChanged = PublishSubject<String>();

    final state = onTextChanged
        .distinct()
        .debounceTime(const Duration(milliseconds: 350))
        .switchMap<SearchState>((String term) => _search(term, movieRepository))
        .startWith(SearchNoTerm());

    return SearchBloc._(onTextChanged, state);
  }

  SearchBloc._(this.onTextChanged, this.state);

  void dispose() {
    onTextChanged.close();
  }

  static Stream<SearchState> _search(
          String term, MovieRepository movieRepository) =>
      term.isEmpty
          ? Stream.value(SearchNoTerm())
          : Rx.fromCallable(() => movieRepository.searchMovie(term, 1))
              .map((result) =>
                  result.isEmpty ? SearchEmpty() : SearchResult(result))
              .startWith(SearchLoading())
              .onErrorReturn(SearchError());
}
