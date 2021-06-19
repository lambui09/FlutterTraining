import 'package:flutter/material.dart';
import 'package:untitled/base/base_adapter.dart';
import 'package:untitled/data/model/movie.dart';
import 'package:untitled/utils/color_utils.dart';
import 'package:untitled/utils/string_local.dart';

import 'movie_item_widget.dart';

abstract class PopularListItem {
  Widget buildNowList(BuildContext context);
}

class PopularMovieAdapter extends BaseAdapter<Movie>
    implements PopularListItem {
  static const double _padding = 20;
  static const double _imgHorizontalRatio = 210 / 140;
  static const double _titleHeight = 30;

  @override
  Widget buildNowList(BuildContext context) {
    if (dataList.isEmpty) {
      return Container(height: 0);
    }

    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemW = screenWidth * 140 / 375;
    final double itemH = itemW * _imgHorizontalRatio;

    return Container(
      height: itemH * 2 + _padding * 3 + _titleHeight,
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
      padding: EdgeInsets.only(left: _padding),
      child: SizedBox(
        width: double.infinity,
        height: _titleHeight,
        child: Padding(
          padding: EdgeInsets.only(top: _padding / 2),
          child: Text(
            StringLocal.popular,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: ColorUtils.textColor102,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListView(double itemW, double itemH) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: _padding,
          mainAxisSpacing: _padding,
          childAspectRatio: _imgHorizontalRatio,
        ),
        itemCount: dataList.length,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(_padding),
        itemBuilder: (BuildContext context, int index) {
          return MovieItemWidget.buildHorizontalNoName(getItem(index)!);
        },
      ),
    );
  }
}
