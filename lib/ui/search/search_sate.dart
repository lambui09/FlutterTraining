// Stream<String>. We call this Stream the onTextChanged "intent".
import 'package:untitled/data/model/movie.dart';

class SearchState {}

class SearchLoading extends SearchState {}

class SearchError extends SearchState {}

class SearchNoTerm extends SearchState {}

class SearchPopulated extends SearchState {
  final List<Movie> items;

  SearchPopulated(this.items);
}

class SearchEmpty extends SearchState {}
