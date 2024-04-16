import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/views/home/manger/cubits/new_release_cubit/new_release_cubit.dart';
import 'package:movies/views/home/manger/cubits/popular_cubit/popular_cubit.dart';
import 'package:movies/views/home/manger/cubits/recomened_cubit/recomended_cubit.dart';
import 'package:movies/views/home/views/widgets/new_releases_listview/new_release_listview.dart';
import 'package:movies/views/home/views/widgets/popular_movies_slider/popular_movies_slider.dart';
import 'package:movies/views/home/views/widgets/recomended_movies_listview/recomended_movies_listview.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PopularCubit()..fetchPopular(),
        ),
        BlocProvider(
          create: (context) => NewReleaseCubit()..fetchNewRelease(),
        ),
        BlocProvider(
          create: (context) => RecomendedCubit()..fetchRecomendedMovies(),
        ),
      ],
      child: const SingleChildScrollView(
        child: Column(
          children: [
            PopularMoviesSlider(),
            NewReleaseListView(),
            SizedBox(
              height: 25,
            ),
            RecomendedMoviesListView(),
            SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
