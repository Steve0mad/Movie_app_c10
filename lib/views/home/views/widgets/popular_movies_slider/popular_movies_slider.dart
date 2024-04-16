import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/components/config/api_config.dart';
import 'package:movies/views/home/manger/cubits/popular_cubit/popular_cubit.dart';
import 'package:movies/views/home/views/widgets/popular_movies_slider/popular_movies_slider_item.dart';
import 'package:movies/views/movie_detail/views/movie_detail_view.dart';

class PopularMoviesSlider extends StatelessWidget {
  const PopularMoviesSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularCubit, PopularState>(
      buildWhen: (previous, next) {
        return previous != next;
      },
      builder: (context, state) {
        var data = BlocProvider.of<PopularCubit>(context).pplMovies;
        if (state is PopularLoading) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is PopularFailure) {
          return Center(
            child: Text(state.errMsg),
          );
        }
        return CarouselSlider.builder(
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.4,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            scrollDirection: Axis.horizontal,
          ),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index, int pageViewIndex) {
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailView.routeName,
                  arguments: {
                    'id': data[index].id,
                    'title': data[index].title,
                  },
                );
              },
              child: PopularMoviesSliderItem(
                imagePath: '${ApiConfig.imageBaseUrl}${data[index].posterPath}',
                title: data[index].title ?? '',
                releaseDate: data[index].releaseDate?.substring(0, 4) ?? '',
                adultOrNot: data[index].adult == false ? 'PG' : 'M',
              ),
            );
          },
        );
      },
    );
  }
}
