import 'package:flutter/material.dart';
import 'package:movies/components/models/results_model.dart';

class MyProvider extends ChangeNotifier {
  List<Results> favoriteMovies = [];

  addToFavorite(Results movie) {
    favoriteMovies.add(movie);
    notifyListeners();
  }

  removeFromFavorite(Results movie) {
    favoriteMovies.remove(movie);
    notifyListeners();
  }
}
