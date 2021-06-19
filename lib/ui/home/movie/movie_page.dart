import 'package:flutter/material.dart';
import 'package:untitled/base/base_page.dart';
import 'package:untitled/data/model/movie.dart';
import 'package:untitled/ui/home/movie/views/now_movie_adapter.dart';
import 'package:untitled/ui/home/movie/views/popular_movie_adapter.dart';
import 'package:untitled/ui/home/movie/views/slider_movie_adapter.dart';
import 'package:untitled/utils/color_utils.dart';
import 'package:untitled/utils/resource_utils.dart';
import 'package:untitled/utils/string_local.dart';

class MoviePage extends BasePage {
  const MoviePage({Key? key}) : super(key: key);

  static const String routerName = "/movie";

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends BasePageState<MoviePage> {
  final List<Movie> _nowItems = [
    Movie('The Flash (2014)',
        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/lJA2RCMfsWoskqlQhXPSLFQGXEJ.jpg'),
    Movie('Loki (2021)',
        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/kEl2t3OhXc3Zb9FBh1AuYzRTgZp.jpg'),
    Movie('Superman & Lois (2021)',
        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/vlv1gn98GqMnKHLSh0dNciqGfBl.jpg'),
    Movie('The Flash (2014)',
        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/lJA2RCMfsWoskqlQhXPSLFQGXEJ.jpg'),
    Movie('Loki (2021)',
        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/kEl2t3OhXc3Zb9FBh1AuYzRTgZp.jpg'),
    Movie('Superman & Lois (2021)',
        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/vlv1gn98GqMnKHLSh0dNciqGfBl.jpg')
  ];

  final NowMovieAdapter _nowMovieAdapter = NowMovieAdapter();
  final SliderMovieAdapter _sliderMovieAdapter = SliderMovieAdapter();
  final PopularMovieAdapter _popularMovieAdapter = PopularMovieAdapter();

  @override
  void init() {
    _nowMovieAdapter.setData(_nowItems);
    _popularMovieAdapter.addData(_nowItems);
    _popularMovieAdapter.addData(_nowItems);
  }

  @override
  void dispose() {
    _sliderMovieAdapter.release();
    super.dispose();
  }

  @override
  Widget renderUI(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [_buildHeader(), Expanded(child: _buildContent())],
      ),
    );
  }

  Widget _buildHeader() {
    final double height = 56;
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Row(children: [
        SizedBox(width: 20),
        Expanded(
          child: Text(
            StringLocal.movies,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: ColorUtils.textColor33),
          ),
        ),
        SizedBox(
          height: height,
          width: height,
          child: InkWell(
            customBorder: CircleBorder(),
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Image.asset(ResourceUtils.ic_search, fit: BoxFit.cover),
            ),
          ),
        ),
        SizedBox(width: 8)
      ]),
    );
  }

  Widget _buildContent() {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _sliderMovieAdapter.buildSlider(screenHeight * 0.22);
          }
          if (index == 1) {
            return _nowMovieAdapter.buildNowList(context);
          }
          return _popularMovieAdapter.buildNowList(context);
        });
  }
}
