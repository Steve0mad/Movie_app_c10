part of 'movie_detail_cubit.dart';

@immutable
sealed class MovieDetailState {}

final class MovieDetailInitial extends MovieDetailState {}

final class MovieDetailLoading extends MovieDetailState {}

final class MovieDetailSuccess extends MovieDetailState {}

final class MovieDetailFailure extends MovieDetailState {
  final String errMsg;
  MovieDetailFailure(this.errMsg);
}
