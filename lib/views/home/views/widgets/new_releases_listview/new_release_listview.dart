import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/components/config/api_config.dart';
import 'package:movies/views/home/manger/cubits/new_release_cubit/new_release_cubit.dart';
import 'package:movies/views/home/views/widgets/new_releases_listview/new_release_listview.item.dart';
import 'package:movies/views/movie_detail/views/movie_detail_view.dart';

class NewReleaseListView extends StatelessWidget {
  const NewReleaseListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      color: const Color(0xFF282A28),
      padding: const EdgeInsets.only(left: 10, top: 14, bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              'New Releases',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<NewReleaseCubit, NewReleaseState>(
              buildWhen: (previous, next) {
                return previous != next;
              },
              builder: (context, state) {
                var data =
                    BlocProvider.of<NewReleaseCubit>(context).newReleaseMovies;
                if (state is NewReleaseLoading) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is NewReleaseFailure) {
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
                      child: NewReleaseListViewItem(
                        movie: data[index],
                        imagePath:
                            '${ApiConfig.imageBaseUrl}${data[index].posterPath}',
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
