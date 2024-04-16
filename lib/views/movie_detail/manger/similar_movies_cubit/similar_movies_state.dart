part of 'similar_movies_cubit.dart';

@immutable
sealed class SimilarMoviesState {}

final class SimilarMoviesInitial extends SimilarMoviesState {}

final class SimilarMoviesLoading extends SimilarMoviesState {}

final class SimilarMoviesSuccess extends SimilarMoviesState {}

final class SimilarMoviesFailure extends SimilarMoviesState {
  final String errMsg;
  SimilarMoviesFailure(this.errMsg);
}
