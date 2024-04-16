import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:movies/components/config/api_config.dart';
import 'package:movies/views/home/manger/models/movie_detail_model.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetail movie = MovieDetail();

  MovieDetailCubit() : super(MovieDetailInitial());

  fetchMovieData(int movieId) async {
    emit(MovieDetailLoading());
    try {
      Uri url = Uri.https(
        ApiConfig.BASE_URL,
        "/3/movie/$movieId?language=en-US",
      );
      http.Response resposne = await http.get(url, headers: {
        "Authorization": ApiConfig.tokenKey,
      });
      Map<String, dynamic> json = jsonDecode(resposne.body);

      MovieDetail movieDetail = MovieDetail.fromJson(json);
      movie = movieDetail;

      emit(MovieDetailSuccess());
    } catch (e) {
      emit(MovieDetailFailure(e.toString()));
    }
  }
}
