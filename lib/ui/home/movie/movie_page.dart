import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/base/base_page.dart';
import 'package:untitled/data/model/movie.dart';
import 'package:untitled/data/source/remote/repository/movie_repository.dart';
import 'package:untitled/ui/home/movie/movie_bloc.dart';
import 'package:untitled/ui/home/movie/views/now_movie_adapter.dart';
import 'package:untitled/ui/home/movie/views/popular_movie_adapter.dart';
import 'package:untitled/ui/home/movie/views/slider_movie_view.dart';

class MoviePage extends BasePage {
  const MoviePage({Key? key}) : super(key: key);

  static const String routeName = "/movie";

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends BasePageState<MoviePage> {
  final List<Movie> _nowItems = [
    Movie(
      '6',
      'The Flash (2014)',
      'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/lJA2RCMfsWoskqlQhXPSLFQGXEJ.jpg',
    ),
    Movie('6', 'Loki (2021)',
        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/kEl2t3OhXc3Zb9FBh1AuYzRTgZp.jpg'),
    Movie('6', 'Superman & Lois (2021)',
        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/vlv1gn98GqMnKHLSh0dNciqGfBl.jpg'),
    Movie('6', 'The Flash (2014)',
        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/lJA2RCMfsWoskqlQhXPSLFQGXEJ.jpg'),
    Movie('6', 'Loki (2021)',
        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/kEl2t3OhXc3Zb9FBh1AuYzRTgZp.jpg'),
    Movie(
      '6',
      'Superman & Lois (2021)',
      'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/vlv1gn98GqMnKHLSh0dNciqGfBl.jpg',
    )
  ];

  late MovieBloc _movieBloc;

  final NowMovieAdapter _nowMovieAdapter = NowMovieAdapter();
  final PopularMovieAdapter _popularMovieAdapter = PopularMovieAdapter();

  @override
  void init() {
    _movieBloc = MovieBloc(RepositoryProvider.of<MovieRepository>(context));
  }

  @override
  Widget renderUI(BuildContext context) {
    return Scaffold(
      body: _buildContent(),
    );
  }

  Widget _build(BuildContext context) {
    return StreamBuilder<List<Movie>>(
        stream: _movieBloc.nowMovieList,
        builder: (context, snapshot) {
          final data = snapshot.data ?? [];
          _nowMovieAdapter.setData(data);
          _popularMovieAdapter.setData(data);
          return _buildContent();
        });
  }

  Widget _buildContent() {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return StreamBuilder<List<Movie>>(
                stream: _movieBloc.sliderMovieList,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? [];
                  return SliderMovieView(data);
                });
          }

          if (index == 1) {
            return StreamBuilder<List<Movie>>(
                stream: _movieBloc.nowMovieList,
                builder: (context, snapshot) {
                  final data = snapshot.data ?? [];
                  _nowMovieAdapter.setData(data);
                  return _nowMovieAdapter.renderUI(context);
                });
          }

          return StreamBuilder<List<Movie>>(
              stream: _movieBloc.popularMovieList,
              builder: (context, snapshot) {
                final data = snapshot.data ?? [];
                _popularMovieAdapter.setData(data);
                return _popularMovieAdapter.renderUI(context);
              });
        });
  }
}
