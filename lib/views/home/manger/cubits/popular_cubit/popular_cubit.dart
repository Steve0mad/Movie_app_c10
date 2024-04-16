import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:movies/components/config/api_config.dart';
import 'package:movies/views/home/manger/models/popular_model.dart';

import '../../../../../components/models/results_model.dart';

part 'popular_state.dart';

class PopularCubit extends Cubit<PopularState> {
  List<Results> pplMovies = [];

  PopularCubit() : super(PopularInitial());

  Future<void> fetchPopular() async {
    emit(PopularLoading());
    try {
      Uri url = Uri.https(
        ApiConfig.BASE_URL,
        "/3/movie/popular",
      );
      http.Response resposne = await http.get(url, headers: {
        "Authorization": ApiConfig.tokenKey,
      });
      Map<String, dynamic> json = jsonDecode(resposne.body);

      Popular popular = Popular.fromJson(json);

      pplMovies = popular.results ?? [];
      emit(PopularSuccess());
    } catch (e) {
      emit(PopularFailure(e.toString()));
    }
  }
}
