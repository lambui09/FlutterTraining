import 'package:flutter/material.dart';
import 'package:untitled/base/base_adapter.dart';
import 'package:untitled/data/model/movie.dart';
import 'package:untitled/utils/extension/size_ext.dart';
import 'package:untitled/utils/resource/color_app.dart';
import 'package:untitled/utils/resource/string_app.dart';

import 'movie_item_view.dart';

class NowMovieAdapter extends BaseAdapter<Movie> {
  static const double _nameHeight = 48;
  static const double _padding = 10;
  static const double _imgHorizontalRatio = 140 / 210;
  static const double _titleHeight = 40;

  const NowMovieAdapter(List<Movie> items) : super(items);

  @override
  Widget buildListItem(BuildContext context) {
    final double screenWidth = getScreenWidth(context);
    final double itemW = screenWidth * 140 / 375;
    final double itemH = itemW / _imgHorizontalRatio + _nameHeight;

    return SizedBox(
      height: itemH + _titleHeight,
      child: Column(
        children: [
          _buildTitleHeader(),
          _buildListItem(),
        ],
      ),
    );
  }

  Widget _buildTitleHeader() {
    return Padding(
      padding: const EdgeInsets.only(left: _padding * 2),
      child: const SizedBox(
        width: double.infinity,
        height: _titleHeight,
        child: Text(
          StringApp.now,
          style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: ColorApp.color_text_102),
        ),
      ),
    );
  }

  Widget _buildListItem() {
    return Expanded(
      child: ListView.builder(
        itemCount: getSize(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: _padding, right: _padding),
        itemBuilder: (BuildContext context, int index) {
          return MovieItemCell(MovieItemType.horizontal, getItem(index),
              (data) {
            print(data.posterUrl);
          });
        },
      ),
    );
  }
}
