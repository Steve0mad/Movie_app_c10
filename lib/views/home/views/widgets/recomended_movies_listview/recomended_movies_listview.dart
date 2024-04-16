import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/components/config/api_config.dart';

import 'package:movies/views/home/manger/cubits/recomened_cubit/recomended_cubit.dart';
import 'package:movies/views/home/views/widgets/recomended_movies_listview/recomended_movies_listview_item.dart';
import 'package:movies/views/movie_detail/views/movie_detail_view.dart';

class RecomendedMoviesListView extends StatelessWidget {
  const RecomendedMoviesListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      color: const Color(0xFF282A28),
      padding: const EdgeInsets.only(left: 10, top: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'Recomended',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<RecomendedCubit, RecomendedState>(
              buildWhen: (previous, next) {
                return previous != next;
              },
              builder: (context, state) {
                var data =
                    BlocProvider.of<RecomendedCubit>(context).recomendedMovies;
                if (state is RecomendedLoading) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is RecomendedFailure) {
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
                            RecomendedMoviesListViewItem(
                              movie: data[index],
                              imagePath:
                                  '${ApiConfig.imageBaseUrl}${data[index].posterPath}',
                            ),
                            Container(
                              width: 130,
                              height: 80,
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
                                        data[index]
                                                .releaseDate
                                                ?.substring(0, 4) ??
                                            '',
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        data[index].adult == false ? 'PG' : 'M',
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
    );
  }
}
