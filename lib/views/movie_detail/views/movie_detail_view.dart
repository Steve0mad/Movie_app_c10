import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/components/config/api_config.dart';
import 'package:movies/views/home/manger/cubits/movie_detail_cubit/movie_detail_cubit.dart';

import 'package:movies/views/movie_detail/views/widgets/movie_detail_custom_item.dart';
import 'package:movies/views/movie_detail/views/widgets/play_trailer_widget.dart';
import 'package:movies/views/movie_detail/views/widgets/similar/similar_listview.dart';

class MovieDetailView extends StatefulWidget {
  static const String routeName = 'MovieDetailView';
  const MovieDetailView({super.key});

  @override
  State<MovieDetailView> createState() => _MovieDetailViewState();
}

class _MovieDetailViewState extends State<MovieDetailView> {
  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    var id = arg['id'];
    var title = arg['title'];
    return BlocProvider(
      create: (context) => MovieDetailCubit()..fetchMovieData(id),
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: SingleChildScrollView(
          child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
            builder: (context, state) {
              if (state is MovieDetailLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              var movie = BlocProvider.of<MovieDetailCubit>(context).movie;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PlayTrailerWidget(
                    imagePath: '${ApiConfig.imageBaseUrl}${movie.posterPath}',
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              movie.releaseDate?.substring(0, 4) ?? '',
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              movie.adult == false ? 'PG' : 'M',
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MvovieDetailCustomItem(
                              imagePath:
                                  '${ApiConfig.imageBaseUrl}${movie.posterPath}',
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.53,
                                  child: Wrap(
                                    runSpacing: 5.0,
                                    spacing: 5.0,
                                    children: movie.genres!
                                        .map(
                                          (e) => Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(e.name!),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: Text(
                                    movie.overview ?? '',
                                    maxLines: 8,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/icons/ic-star.png',
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      movie.voteAverage!
                                          .toString()
                                          .substring(0, 3),
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  SimilarMoviesListView(movieId: movie.id ?? 0),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
