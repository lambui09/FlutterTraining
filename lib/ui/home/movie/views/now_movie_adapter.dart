import 'package:flutter/material.dart';
import 'package:untitled/base/base_adapter.dart';
import 'package:untitled/data/model/movie.dart';
import 'package:untitled/utils/color_utils.dart';
import 'package:untitled/utils/string_local.dart';

import 'movie_item_widget.dart';

abstract class NowListItem {
  Widget buildNowList(BuildContext context);
}

class NowMovieAdapter extends BaseAdapter<Movie> implements NowListItem {
  static const double _nameHeight = 48;
  static const double _padding = 10;
  static const double _imgHorizontalRatio = 140 / 210;
  static const double _titleHeight = 40;
  static const EdgeInsets margin = EdgeInsets.symmetric(horizontal: _padding);

  @override
  Widget buildNowList(BuildContext context) {
    if (dataList.isEmpty) {
      return Container(height: 0);
    }

    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemW = screenWidth * 140 / 375;
    final double itemH = itemW / _imgHorizontalRatio + _nameHeight;

    return Container(
      height: itemH + _titleHeight,
      child: Column(
        children: [
          _buildTitleHeader(),
          _buildListView(itemW, itemH),
        ],
      ),
    );
  }

  Widget _buildTitleHeader() {
    return Padding(
      padding: EdgeInsets.only(left: _padding * 2),
      child: SizedBox(
        width: double.infinity,
        height: _titleHeight,
        child: Text(
          StringLocal.now,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: ColorUtils.textColor102),
        ),
      ),
    );
  }

  Widget _buildListView(double itemW, double itemH) {
    return Expanded(
      child: ListView.builder(
        itemCount: dataList.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: _padding, right: _padding),
        itemBuilder: (BuildContext context, int index) {
          return MovieItemWidget.buildHorizontal(
              getItem(index)!, itemW, itemH, margin);
        },
      ),
    );
  }
}
