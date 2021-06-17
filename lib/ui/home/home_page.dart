import 'package:flutter/material.dart';
import 'package:untitled/base/base_page.dart';
import 'package:untitled/ui/home/items/move_widget_item.dart';
import 'package:untitled/utils/color_utils.dart';
import 'package:untitled/utils/resource_utils.dart';
import 'package:untitled/utils/string_local.dart';

class HomePage extends BasePage {
  const HomePage({Key? key}) : super(key: key);

  static const String routerName = "/home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage> {
  static const int _sliderItemCount = 4;
  static const double _padding = 20;
  final PageController _pageController = PageController(viewportFraction: 0.9);

  final List<MovieWidgetItem> _nowWidgetItems = [
    MovieWidgetItem('The Flash (2014)',
        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/lJA2RCMfsWoskqlQhXPSLFQGXEJ.jpg'),
    MovieWidgetItem('Loki (2021)',
        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/kEl2t3OhXc3Zb9FBh1AuYzRTgZp.jpg'),
    MovieWidgetItem('Superman & Lois (2021)',
        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/vlv1gn98GqMnKHLSh0dNciqGfBl.jpg'),
    MovieWidgetItem('The Flash (2014)',
        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/lJA2RCMfsWoskqlQhXPSLFQGXEJ.jpg'),
    MovieWidgetItem('Loki (2021)',
        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/kEl2t3OhXc3Zb9FBh1AuYzRTgZp.jpg'),
    MovieWidgetItem('Superman & Lois (2021)',
        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2/vlv1gn98GqMnKHLSh0dNciqGfBl.jpg')
  ];

  @override
  void init() {}

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget renderUI(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
            children: [_buildHeader(), Expanded(child: _buildContent())]),
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
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            return _buildSlider();
          }
          return _buildNowList();
        });
  }

  Widget _buildSlider() {
    return SizedBox(
      width: double.infinity,
      height: screenHeight * 0.22,
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

  Widget _buildNowList() {
    return Container(
      width: double.infinity,
      height: screenHeight * 0.36,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: EdgeInsets.only(left: _padding),
          child: SizedBox(
            width: double.infinity,
            height: 40,
            child: Text(
              StringLocal.now,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: ColorUtils.textColor102),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _nowWidgetItems.length,
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: _padding / 2, right: _padding / 2),
            itemBuilder: (BuildContext context, int index) {
              return _nowWidgetItems[index].buildHorizontal(context);
            },
          ),
        ),
      ]),
    );
  }
}
