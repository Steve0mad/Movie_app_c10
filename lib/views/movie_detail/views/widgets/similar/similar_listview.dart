import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/components/config/api_config.dart';

import 'package:movies/views/movie_detail/manger/similar_movies_cubit/similar_movies_cubit.dart';
import 'package:movies/views/movie_detail/views/movie_detail_view.dart';
import 'package:movies/views/movie_detail/views/widgets/similar/similar_listview_item.dart';

class SimilarMoviesListView extends StatelessWidget {
  const SimilarMoviesListView({super.key, required this.movieId});

  final int movieId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SimilarMoviesCubit()..fetchSimilarMovies(movieId),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.34,
        color: const Color(0xFF282A28),
        padding: const EdgeInsets.only(left: 10, top: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'More Like This',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<SimilarMoviesCubit, SimilarMoviesState>(
                builder: (context, state) {
                  var data =
                      BlocProvider.of<SimilarMoviesCubit>(context).movies;
                  if (state is SimilarMoviesLoading) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (state is SimilarMoviesFailure) {
                    return Center(
                      child: Text(state.errMsg),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SimilarMoviesListViewItem(
                                movie: data[index],
                                imagePath:
                                    '${ApiConfig.imageBaseUrl}${data[index].posterPath}',
                              ),
                              Container(
                                width: 130,
                                height: 100,
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  color: Color(0xFF343534),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/icons/ic-star.png',
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          data[index]
                                              .voteAverage!
                                              .toString()
                                              .substring(0, 3),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      data[index].title ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          data[index].releaseDate ?? '',
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          data[index].adult == false
                                              ? 'PG'
                                              : 'M',
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
