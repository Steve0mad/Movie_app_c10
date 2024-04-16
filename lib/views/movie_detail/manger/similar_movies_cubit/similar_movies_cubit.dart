import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:movies/components/config/api_config.dart';
import 'package:movies/components/models/results_model.dart';
import 'package:movies/views/movie_detail/manger/models/similar_movies_model.dart';

part 'similar_movies_state.dart';

class SimilarMoviesCubit extends Cubit<SimilarMoviesState> {
  SimilarMoviesCubit() : super(SimilarMoviesInitial());

  List<Results> movies = [];

  Future<void> fetchSimilarMovies(int id) async {
    emit(SimilarMoviesLoading());
    try {
      Uri url = Uri.https(
        ApiConfig.BASE_URL,
        "/3/movie/$id/similar",
      );
      http.Response resposne = await http.get(url, headers: {
        "Authorization": ApiConfig.tokenKey,
      });
      Map<String, dynamic> json = jsonDecode(resposne.body);

      SimilarMovies similarMovies = SimilarMovies.fromJson(json);
      movies = similarMovies.results ?? [];
      emit(SimilarMoviesSuccess());
    } catch (e) {
      emit(SimilarMoviesFailure(e.toString()));
    }
  }
}
