import 'package:flutter/material.dart';
import 'package:untitled/base/base_page.dart';
import 'package:untitled/ui/home/tv/tv_page.dart';
import 'package:untitled/utils/color_utils.dart';
import 'package:untitled/utils/string_local.dart';
import 'movie/movie_page.dart';

class HomePage extends BasePage {
  const HomePage({Key? key}) : super(key: key);

  static const String routerName = "/home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomePage> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <StatefulWidget>[
    MoviePage(),
    TvPage(),
    TvPage(),
  ];

  @override
  void init() {}

  @override
  Widget renderUI(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.movie),
          label: StringLocal.movies,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.tv),
          label: StringLocal.tv,
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.pages_rounded), label: StringLocal.profile),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: ColorUtils.tabBarSelectedTextColor,
      unselectedItemColor: ColorUtils.tabBarUnSelectedTextColor,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
