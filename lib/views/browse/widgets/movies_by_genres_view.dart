import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/components/config/api_config.dart';
import 'package:movies/views/browse/manger/movies_genres/movies_genres_cubit.dart';
import 'package:movies/views/movie_detail/views/movie_detail_view.dart';

class MoviesByGenresView extends StatelessWidget {
  static const String routeName = 'MoviesByGenresView';
  const MoviesByGenresView({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as Map;
    var id = arg['id'] as int;
    var name = arg['name'] as String;
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: BlocProvider(
        create: (context) => MoviesGenresCubit()..fetchMoviesByGenres(id),
        child: BlocBuilder<MoviesGenresCubit, MoviesGenresState>(
          builder: (context, state) {
            var data = BlocProvider.of<MoviesGenresCubit>(context).movies;
            if (state is MoviesGenresLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is MoviesGenresFailure) {
              return Center(
                child: Text(state.errMsg),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(25.0),
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(
                      bottom: 12.0,
                      top: 5,
                    ),
                    child: Divider(
                      color: Colors.white,
                      thickness: 0.5,
                    ),
                  );
                },
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              imageUrl:
                                  '${ApiConfig.imageBaseUrl}${data[index].posterPath}',
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                data[index].title ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Text(
                              data[index].releaseDate?.substring(0, 4) ?? '',
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
