import 'package:flutter/material.dart';
import 'package:untitled/base/base_page.dart';
import 'package:untitled/data/model/movie.dart';
import 'package:untitled/ui/home/detail/movie_detail_bloc.dart';

class MovieDetailPage extends BaseStateFul {
  const MovieDetailPage({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  static const String routeName = "/movie_detail";

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState
    extends BaseBlocState<MovieDetailPage, MovieDetailBloc> {
  @override
  Widget buildUI(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }

  @override
  void init() {}
}
