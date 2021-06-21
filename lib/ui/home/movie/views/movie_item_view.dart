import 'package:flutter/material.dart';
import 'package:untitled/base/base_adapter.dart';
import 'package:untitled/data/model/movie.dart';
import 'package:untitled/utils/color_app.dart';

enum MovieItemType { horizontal, horizontalNoName }

class MovieItemCell extends BaseItemCell<Movie> {
  final MovieItemType itemType;

  static const double _padding = 10;
  static const double _imgHorizontalRatio = 210 / 140;
  static const EdgeInsets margin = EdgeInsets.symmetric(horizontal: _padding);

  MovieItemCell(this.itemType, Movie data, Function(Movie) onTap)
      : super(data, onTap);

  @override
  Widget renderUI(BuildContext context, Movie data) {
    switch (itemType) {
      case MovieItemType.horizontal:
        return _buildHorizontal(context, data);
      case MovieItemType.horizontalNoName:
        return _buildHorizontalNoName(data);
    }
  }

  Widget _buildHorizontal(BuildContext context, Movie movie) {

    final double screenWidth = MediaQuery.of(context).size.width;
    final double itemW = screenWidth * 140 / 375;
    final double itemH = itemW * _imgHorizontalRatio;

    return Container(
      margin: margin,
      width: itemW,
      height: itemH,
      child: Column(children: [
        AspectRatio(
          aspectRatio: 140 / 210,
          child: PhysicalModel(
            color: Colors.transparent,
            elevation: 10,
            shadowColor: Colors.black,
            borderRadius: BorderRadius.circular(24),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(movie.posterUrl, fit: BoxFit.cover),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: Text(
              movie.title.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.3,
                fontSize: 15,
                color: ColorUtils.color_text_33,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildHorizontalNoName(Movie movie) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: 10,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Stack(
          children: [
            Image.network(movie.posterUrl, fit: BoxFit.cover),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: EdgeInsets.only(top: 10, right: 10),
                width: 32,
                height: 32,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(249, 159, 0, 1),
                            Color.fromRGBO(219, 48, 105, 1),
                          ]),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '9',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        Text(
                          '.',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                        Text(
                          '4',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
