import 'package:flutter/material.dart';
import 'package:untitled/base/base_adapter.dart';
import 'package:untitled/data/model/movie.dart';
import 'package:untitled/utils/color_app.dart';
import 'package:untitled/utils/string_app.dart';
import 'movie_item_view.dart';

class PopularMovieAdapter extends BaseAdapter<Movie> {
  static const double _padding = 20;
  static const double _imgHorizontalRatio = 210 / 140;
  static const double _titleHeight = 30;

  @override
  Widget renderUI(BuildContext context) {
    if (dataList.isEmpty) {
      return const SizedBox();
    }

    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemW = screenWidth * 140 / 375;
    final double itemH = itemW * _imgHorizontalRatio;

    return SizedBox(
      height: itemH * 2 + _padding * 3 + _titleHeight,
      child: Column(
        children: [
          _buildTitleHeader(),
          _buildListView(),
        ],
      ),
    );
  }

  Widget _buildTitleHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: _padding),
      child: const SizedBox(
        width: double.infinity,
        height: _titleHeight,
        child: Padding(
          padding: const EdgeInsets.only(top: _padding / 2),
          child: Text(
            StringApp.popular,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: ColorUtils.color_text_102,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListView() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: _padding,
          mainAxisSpacing: _padding,
          childAspectRatio: _imgHorizontalRatio,
        ),
        itemCount: getSize(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(_padding),
        itemBuilder: (BuildContext context, int index) {
          return MovieItemCell(MovieItemType.horizontalNoName, getItem(index)!,
              (data) {
            print(data.posterUrl);
          });
        },
      ),
    );
  }
}
