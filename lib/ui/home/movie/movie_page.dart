import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';
import 'package:untitled/base/base_page.dart';
import 'package:untitled/data/model/movie.dart';
import 'package:untitled/data/source/remote/repository/movie_repository.dart';
import 'package:untitled/ui/home/movie/movie_bloc.dart';

import 'widgets/now_movie_adapter.dart';
import 'widgets/popular_movie_adapter.dart';
import 'widgets/slider_movie_view.dart';

class MoviePage extends BasePage {
  const MoviePage({Key? key}) : super(key: key);

  static const String routeName = "/movie";

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends BasePageState<MoviePage> {
  late MovieBloc _movieBloc;

  @override
  void init() {
    _movieBloc = MovieBloc(RepositoryProvider.of<MovieRepository>(context));
  }

  @override
  Widget buildUI(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Tuple3<List<Movie>, List<Movie>, List<Movie>>>(
        stream: _movieBloc.dataList,
        builder: (context, snapshot) {
          final data = snapshot.data;
          return ListView.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return SliderMovieView(data?.item1 ?? []);
              }
              if (index == 1) {
                return NowMovieAdapter(data?.item2 ?? []);
              }
              return PopularMovieAdapter(data?.item3 ?? []);
            },
          );
        },
      ),
    );
  }
}
