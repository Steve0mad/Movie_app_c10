import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movies/components/my_provider.dart';
import 'package:movies/components/observer.dart';
import 'package:movies/views/browse/widgets/movies_by_genres_view.dart';

import 'package:movies/views/home/views/home_view.dart';
import 'package:movies/views/movie_detail/views/movie_detail_view.dart';
import 'package:movies/views/splash/splash_view.dart';
import 'package:provider/provider.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: SplashView.routeName,
        theme: ThemeData.dark(),
        routes: {
          SplashView.routeName: (context) =>  SplashView(),
          HomeView.routeName: (context) =>  HomeView(),
          MovieDetailView.routeName: (context) =>  MovieDetailView(),
          MoviesByGenresView.routeName: (context) =>  MoviesByGenresView(),
        },
      ),
    );
  }
}
