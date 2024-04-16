import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:movies/components/config/api_config.dart';
import 'package:movies/views/search/manger/models/search_movies_model.dart';

import '../../../../components/models/results_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  List<Results> movies = [];

  Future<void> fetchSearchedMovies(String text) async {
    emit(SearchLoading());
    try {
      Uri url = Uri.https(ApiConfig.BASE_URL, "/3/search/movie", {
        'query': text,
      });
      http.Response resposne = await http.get(url, headers: {
        "Authorization": ApiConfig.tokenKey,
      });
      Map<String, dynamic> json = jsonDecode(resposne.body);

      SearchMovies searchMovies = SearchMovies.fromJson(json);

      movies = searchMovies.results ?? [];

      emit(SearchSuccess());
    } catch (e) {
      emit(SearchFailure(e.toString()));
    }
  }
}
