part of 'popular_cubit.dart';

@immutable
sealed class PopularState {}

final class PopularInitial extends PopularState {}

final class PopularLoading extends PopularState {}

final class PopularSuccess extends PopularState {}

final class PopularFailure extends PopularState {
  final String errMsg;
  PopularFailure(this.errMsg);
}
