import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:movies/components/config/api_config.dart';
import 'package:movies/views/home/manger/models/recomended_model.dart';

import '../../../../../components/models/results_model.dart';

part 'recomended_state.dart';

class RecomendedCubit extends Cubit<RecomendedState> {
  List<Results> recomendedMovies = [];

  RecomendedCubit() : super(RecomendedInitial());

  Future<void> fetchRecomendedMovies() async {
    emit(RecomendedLoading());
    try {
      Uri url = Uri.https(
        ApiConfig.BASE_URL,
        "/3/movie/popular",
      );
      http.Response resposne = await http.get(url, headers: {
        "Authorization": ApiConfig.tokenKey,
      });
      Map<String, dynamic> json = jsonDecode(resposne.body);

      Recomended recomended = Recomended.fromJson(json);

      recomendedMovies = recomended.results ?? [];
      emit(RecomendedSuccess());
    } catch (e) {
      emit(RecomendedFailure(e.toString()));
    }
  }
}
