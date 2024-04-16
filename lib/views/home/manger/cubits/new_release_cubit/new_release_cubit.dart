import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:movies/components/config/api_config.dart';
import 'package:movies/views/home/manger/models/new_release_model.dart';

import '../../../../../components/models/results_model.dart';

part 'new_release_state.dart';

class NewReleaseCubit extends Cubit<NewReleaseState> {
  List<Results> newReleaseMovies = [];

  NewReleaseCubit() : super(NewReleaseInitial());

  Future<void> fetchNewRelease() async {
    emit(NewReleaseLoading());
    try {
      Uri url = Uri.https(
        ApiConfig.BASE_URL,
        "/3/movie/upcoming",
      );
      http.Response resposne = await http.get(url, headers: {
        "Authorization": ApiConfig.tokenKey,
      });
      Map<String, dynamic> json = jsonDecode(resposne.body);
      NewRelease newRelease = NewRelease.fromJson(json);
      newReleaseMovies = newRelease.results ?? [];
      emit(NewReleaseSuccess());
    } catch (e) {
      emit(NewReleaseFailure(e.toString()));
    }
  }
}
