import 'package:flutter/material.dart';
import 'package:untitled/data/model/movie.dart';
import 'package:untitled/utils/color_utils.dart';

abstract class MovieListItem {
  Widget buildHorizontal(BuildContext context);

  Widget buildVertical(BuildContext context);
}

class MovieWidgetItem extends Movie implements MovieListItem {
  MovieWidgetItem(String name, String imgUrl) : super(name, imgUrl);

  static const double _nameHeight = 48;
  static const double _padding = 10;

  double heightItem(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width * 140 / 375;
    double height = width * 238 / 140 + _nameHeight;
    return height;
  }

  @override
  Widget buildHorizontal(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width * 140 / 375;
    double height = width * 238 / 140 + _nameHeight;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: _padding),
      width: width,
      height: height,
      child: Column(
        children: [
          Expanded(
            child: PhysicalModel(
              color: Colors.transparent,
              elevation: 10,
              shadowColor: Colors.black,
              borderRadius: BorderRadius.circular(24),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imgUrl, fit: BoxFit.cover),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: _nameHeight,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
              child: Text(
                name.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.3, fontSize: 15, color: ColorUtils.textColor33),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildVertical(BuildContext context) => Column();
}
