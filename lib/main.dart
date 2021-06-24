import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/data/source/remote/AppClient.dart';
import 'package:untitled/ui/home/main_bloc.dart';
import 'package:untitled/ui/home/main_page.dart';
import 'package:untitled/ui/search/search_bloc.dart';
import 'package:untitled/ui/search/search_page.dart';
import 'package:untitled/ui/splash/splash_page.dart';
import 'package:untitled/ui/tutorial/tutorial_page.dart';

import 'data/source/remote/repository/movie_repository.dart';

final apiService = ApiService();
final movieRepository = MovieRepositoryImpl(apiService);

void main() {
  final repositoryProviders = [
    RepositoryProvider<ApiService>(
      create: (context) => apiService,
    ),
    RepositoryProvider<MovieRepository>(
      create: (context) => movieRepository,
    ),
  ];

  runApp(MultiRepositoryProvider(
    providers: repositoryProviders,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final routes = <String, WidgetBuilder>{
      SplashPage.routeName: (context) => SplashPage(),
      TutorialPage.routeName: (context) => TutorialPage(),
      MainPage.routeName: (context) {
        return BlocProvider(
          create: (context) => MainBloc(),
          child: MainPage(),
        );
      },
      SearchPage.routeName: (context) {
        return BlocProvider(
          create: (context) => SearchBloc(context.read<MovieRepository>()),
          child: SearchPage(),
        );
      },
    };

    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
      routes: routes,
    );
  }
}
