import 'package:flutter/material.dart';

class SliderMovieAdapter {
  static const int _sliderItemCount = 4;

  final PageController _pageController = PageController(viewportFraction: 0.9);

  void release() {
    _pageController.dispose();
  }

  Widget buildSlider(double height) {
    return Container(
      width: double.infinity,
      height: height,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _sliderItemCount,
        itemBuilder: (context, index) {
          return Container(
            margin: _marginSlider(index),
            child: _buildImageSlider(index),
          );
        },
      ),
    );
  }

  EdgeInsets _marginSlider(int index) {
    switch (index) {
      case 0:
        return EdgeInsets.only(left: 0, right: 10, bottom: 20);
      case _sliderItemCount - 1:
        return EdgeInsets.only(left: 10, right: 0, bottom: 20);
      default:
        return EdgeInsets.only(left: 10, right: 10, bottom: 20);
    }
  }

  String _urlSlider(int index) {
    return index % 2 == 0
        ? 'https://townsquare.media/site/442/files/2018/04/trollhunters-yelchin-hirsch-pic.jpg?w=980&q=75'
        : 'https://genk.mediacdn.vn/k:thumb_w/640/2016/2-1467964928155/lichsuwarcrafttoantapphan4durotannguoithulinhhuyenthoaicuatocorc.png';
  }

  Widget _buildImageSlider(int index) {
    return PhysicalModel(
      color: Colors.transparent,
      elevation: 10,
      shadowColor: Colors.black,
      borderRadius: BorderRadius.circular(24),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(_urlSlider(index), fit: BoxFit.cover),
      ),
    );
  }
}
