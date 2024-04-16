part of 'recomended_cubit.dart';

@immutable
sealed class RecomendedState {}

final class RecomendedInitial extends RecomendedState {}

final class RecomendedLoading extends RecomendedState {}

final class RecomendedSuccess extends RecomendedState {}

final class RecomendedFailure extends RecomendedState {
  final String errMsg;
  RecomendedFailure(this.errMsg);
}
