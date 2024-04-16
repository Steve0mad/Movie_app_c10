part of 'movies_genres_cubit.dart';

@immutable
sealed class MoviesGenresState {}

final class MoviesGenresInitial extends MoviesGenresState {}

final class MoviesGenresLoading extends MoviesGenresState {}

final class MoviesGenresSuccess extends MoviesGenresState {}

final class MoviesGenresFailure extends MoviesGenresState {
  final String errMsg;

  MoviesGenresFailure(this.errMsg);
}
