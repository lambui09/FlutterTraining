import 'package:flutter/material.dart';
import 'package:untitled/base/base_page.dart';
import 'package:untitled/ui/home/tv/tv_page.dart';
import 'package:untitled/utils/color_app.dart';
import 'package:untitled/utils/resource_app.dart';
import 'package:untitled/utils/string_app.dart';
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
  Widget renderUI(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        bottom: true,
        child: Column(children: [
          _buildHeader(),
          Expanded(child: _widgetOptions[_selectedIndex]),
        ],),
      ),
      bottomNavigationBar: _buildBottomNav(),
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
            StringApp.movies,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.normal,
                color: ColorUtils.color_text_33),
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
      selectedItemColor: ColorUtils.color_tabBar_selected_text,
      unselectedItemColor: ColorUtils.color_tabBar_un_selected_text,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
