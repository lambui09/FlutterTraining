import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuple/tuple.dart';
import 'package:untitled/base/base_page.dart';
import 'package:untitled/data/model/movie.dart';
import 'package:untitled/data/source/remote/repository/movie_repository.dart';
import 'package:untitled/ui/home/tv/tv_block.dart';
import 'package:untitled/ui/home/widgets/movie_item_view.dart';
import 'package:untitled/ui/home/widgets/now_movie_adapter.dart';
import 'package:untitled/utils/resource/color_app.dart';
import 'package:untitled/utils/resource/string_app.dart';

class TvPage extends BasePage {
  const TvPage({Key? key}) : super(key: key);

  static const String routerName = "/tv";

  @override
  _TvPageState createState() => _TvPageState();
}

class _TvPageState extends BasePageState<TvPage> {
  late TvBloc _tvBloc;

  @override
  void init() {
    _tvBloc = TvBloc(RepositoryProvider.of<MovieRepository>(context));
  }

  @override
  Widget buildUI(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<Tuple2<List<Movie>, List<Movie>>>(
        stream: _tvBloc.dataList,
        builder: (context, snapshot) {
          final data = snapshot.data;
          final nowMovieList = data?.item1 ?? [];
          final popularMovieList = data?.item2 ?? [];

          final nowItemCount = 1;
          final popularItemCount = popularMovieList.length + 1;
          final itemCount = nowItemCount + popularItemCount;

          if (itemCount == 0) {
            return SizedBox();
          }

          return ListView.builder(
            itemCount: itemCount,
            itemBuilder: (BuildContext context, int index) {
              if (index == 0) {
                return NowMovieAdapter(nowMovieList);
              }
              if (popularMovieList.isEmpty) {
                return const SizedBox();
              }
              if (index == 1) {
                return _buildPopularTitleHeader();
              }
              return MovieItemCell(MovieItemType.verticalFullWidth,
                  popularMovieList[index - 2], (movie) {});
            },
          );
        },
      ),
    );
  }

  Widget _buildPopularTitleHeader() {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      width: double.infinity,
      child: Text(
        StringApp.popular,
        textAlign: TextAlign.start,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: ColorApp.color_text_102,
        ),
      ),
    );
  }
}
