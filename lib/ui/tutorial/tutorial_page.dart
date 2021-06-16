import 'package:flutter/material.dart';
import 'package:untitled/base/base_page.dart';

class TutorialPage extends BasePage {
  static TutorialPage instance() => TutorialPage();

  final String screenName = "TutorialPage";

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends BasePageState<TutorialPage> {
  String getTitle() => _titleList[_currentPage];
  final List<String> _titleList = [
    "Get the first\nMovie &TV\ninformation",
    "Know the movie\nis not worth\nWatching",
    "Real-time\nupdates movie\nTrailer"
  ];

  String getTitleBtn() => _titleBtnList[_currentPage];
  final List<String> _titleBtnList = ["Next", "Next", "Get Stared"];

  late final PageController _pageController;
  var _currentPage = 0;
  var _isLastPage = false;

  @override
  void init() {
    _pageController = PageController(initialPage: 0);
    _pageController.addListener(() {
      int? page = _pageController.page?.round().toInt();
      if (page != null && page != _currentPage) {
        print(page);
        setState(() {
          _currentPage = page;
          _isLastPage = page == _titleBtnList.length - 1;
        });
      }
    });
  }

  @override
  Widget renderUI(BuildContext context) {
    return Scaffold(
        body: Stack(children: [pageControllerWidget(), contentWidget()]));
  }

  Widget pageControllerWidget() {
    return PageView(
        scrollDirection: Axis.horizontal,
        controller: _pageController,
        children: [
          Stack(
            children: [
              Container(color: Colors.black),
              Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset('assets/images/tutorial1.png',
                      fit: BoxFit.fitWidth)),
              Container(
                  decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: FractionalOffset(0.0, 0.5),
                    end: FractionalOffset(0.5, 1.0),
                    colors: [
                      Color.fromRGBO(245, 144, 14, 0.17),
                      Color.fromRGBO(219, 49, 103, 1)
                    ]),
              ))
            ],
          ),
          Stack(
            children: [
              Container(color: Colors.white),
              Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset('assets/images/tutorial2.png',
                      fit: BoxFit.fitWidth)),
              Container(
                  decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: FractionalOffset(0.5, 0.5),
                    end: FractionalOffset(1.0, 1.0),
                    colors: [
                      Color.fromRGBO(245, 213, 71, 0.0),
                      Color.fromRGBO(245, 213, 71, 1)
                    ]),
              ))
            ],
          ),
          Stack(
            children: [
              Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset('assets/images/tutorial3.png',
                      fit: BoxFit.fitWidth)),
              Container(
                  decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(0.5, 0.7),
                    colors: [
                      Color.fromRGBO(52, 92, 197, 0.0),
                      Color.fromRGBO(20, 34, 70, 1)
                    ]),
              ))
            ],
          )
        ]);
  }

  Widget contentWidget() {
    return Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(bottom: screenHeight * 0.12),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(
            getTitle(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 34,
              height: 1.3,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16),
          dotsWidget(),
          SizedBox(height: 56),
          buttonWidget()
        ]));
  }

  Widget dotsWidget() {
    return Container(
        width: 68,
        height: 16,
        child: ListView(
            children: dotsView(),
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics()));
  }

  List<Widget> dotsView() {
    final views = <Widget>[];
    for (var i = 0; i < _titleList.length; i++) {
      double opacity = i == _currentPage ? 1 : 0.4;
      views.add(Container(
          margin: EdgeInsets.only(right: 10),
          child: Opacity(
              opacity: opacity,
              child: Image.asset('assets/images/logo.png',
                  fit: BoxFit.fitHeight))));
    }
    return views;
  }

  Widget buttonWidget() {
    double width = 192;
    double height = 54;
    double radius = height / 2;
    Color borderColor = _isLastPage ? Colors.transparent : Colors.white;
    return ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Stack(children: [
          Visibility(
              visible: _isLastPage,
              child: Positioned.fill(
                  child: Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: FractionalOffset(0.0, 0.5),
                              end: FractionalOffset(1.0, 1.0),
                              colors: [
                    Color.fromRGBO(249, 159, 0, 1),
                    Color.fromRGBO(219, 48, 105, 1)
                  ]))))),
          SizedBox(
              width: width,
              height: height,
              child: TextButton(
                  onPressed: () {
                    nextPage();
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(radius),
                          side: BorderSide(color: borderColor)))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(getTitleBtn(),
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.white)),
                      Visibility(
                          visible: !_isLastPage, child: SizedBox(width: 12)),
                      Visibility(
                          visible: !_isLastPage,
                          child: SizedBox(
                              child: Icon(Icons.arrow_forward_sharp,
                                  color: Colors.white)))
                    ],
                  )))
        ]));
  }

  void nextPage() {
    if (_isLastPage) {
      return;
    }
    _pageController.animateToPage(_currentPage + 1,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void nextToScreen() {}
}
