import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/components/config/api_config.dart';
import 'package:movies/views/movie_detail/views/movie_detail_view.dart';

import 'package:movies/views/search/manger/search_cubit/search_cubit.dart';
import 'package:movies/views/search/views/widgets/custom_text_field.dart';

class SearchViewBody extends StatelessWidget {
  SearchViewBody({super.key});

  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SearchFailure) {
            return Center(
              child: Text(state.errMsg),
            );
          }
          var data = BlocProvider.of<SearchCubit>(context).movies;

          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                CustomTextField(
                  onPressed: () {
                    BlocProvider.of<SearchCubit>(context)
                        .fetchSearchedMovies(controller.text);
                  },
                  controller: controller,
                ),
                const SizedBox(
                  height: 25,
                ),
                Expanded(
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
                                  data[index].releaseDate?.substring(0, 4) ??
                                      '',
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
