import 'package:untitled/base/base_bloc.dart';

class MovieDetailBloc extends BaseBloc<EmptyState> {
  MovieDetailBloc._() : super(EmptyState());

  factory MovieDetailBloc() {
    return MovieDetailBloc._();
  }

  @override
  void dispose() {}
}
