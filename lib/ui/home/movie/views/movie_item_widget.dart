import 'package:flutter/material.dart';
import 'package:untitled/data/model/movie.dart';
import 'package:untitled/utils/color_utils.dart';

class MovieItemWidget {
  static Widget buildHorizontal(
      Movie movie, double width, double height, EdgeInsets margin) {
    return Container(
      margin: margin,
      width: width,
      height: height,
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
              child: Image.network(movie.imgUrl, fit: BoxFit.cover),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: Text(
              movie.name.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                height: 1.3,
                fontSize: 15,
                color: ColorUtils.textColor33,
              ),
            ),
          ),
        ),
      ]),
    );
  }

  static Widget buildHorizontalNoName(Movie movie) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: 10,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Stack(
          children: [
            Image.network(movie.imgUrl, fit: BoxFit.cover),
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
