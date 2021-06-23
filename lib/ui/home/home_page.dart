import 'package:flutter/material.dart';
import 'package:untitled/base/base_page.dart';
import 'package:untitled/ui/home/tv/tv_page.dart';
import 'package:untitled/ui/search/search_page.dart';
import 'package:untitled/utils/navigate_utils.dart';
import 'package:untitled/utils/resource/color_app.dart';
import 'package:untitled/utils/resource/image_app.dart';
import 'package:untitled/utils/resource/string_app.dart';

import 'movie/movie_page.dart';

class HomePage extends BasePage {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = "/home";

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
  Widget buildUI(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: IndexedStack(
                index: _selectedIndex,
                children: _widgetOptions,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  String _getTitleHeader() {
    if (_selectedIndex == 0) {
      return StringApp.movies;
    }
    if (_selectedIndex == 1) {
      return StringApp.tv;
    }
    return StringApp.profile;
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
            _getTitleHeader(),
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: ColorApp.color_text_33),
          ),
        ),
        SizedBox(
          height: height,
          width: height,
          child: InkWell(
            customBorder: CircleBorder(),
            onTap: () {
              NavigateUtils.pushActivity(context, SearchPage());
            },
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Image.asset(ImageApp.ic_search, fit: BoxFit.cover),
            ),
          ),
        ),
        SizedBox(width: 8)
      ]),
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.movie),
          label: StringApp.movies,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.tv),
          label: StringApp.tv,
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.pages_rounded), label: StringApp.profile),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: ColorApp.color_tabBar_selected_text,
      unselectedItemColor: ColorApp.color_tabBar_un_selected_text,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) {
      return;
    }

    setState(() {
      _selectedIndex = index;
    });
  }
}
