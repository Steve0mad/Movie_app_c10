import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:movies/components/config/api_config.dart';
import 'package:movies/views/browse/manger/models/movies_genres_model.dart';

part 'movies_genres_state.dart';

class MoviesGenresCubit extends Cubit<MoviesGenresState> {
  MoviesGenresCubit() : super(MoviesGenresInitial());

  List<Results> movies = [];

  Future<void> fetchMoviesByGenres(int categoryId) async {
    emit(MoviesGenresLoading());
    String genreIdAsString = categoryId.toString();
    try {
      Uri url = Uri.https(ApiConfig.BASE_URL, "/3/discover/movie", {
        'with_genres': genreIdAsString,
        'sort_by': 'popularity.desc',
      });
      http.Response resposne = await http.get(url, headers: {
        "Authorization": ApiConfig.tokenKey,
      });
      Map<String, dynamic> json = jsonDecode(resposne.body);

      MoviesGenres moviesGenres = MoviesGenres.fromJson(json);

      movies = moviesGenres.results ?? [];

      emit(MoviesGenresSuccess());
    } catch (e) {
      emit(MoviesGenresFailure(e.toString()));
    }
  }
}
