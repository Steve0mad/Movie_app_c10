part of 'new_release_cubit.dart';

@immutable
sealed class NewReleaseState {}

final class NewReleaseInitial extends NewReleaseState {}

final class NewReleaseLoading extends NewReleaseState {}

final class NewReleaseSuccess extends NewReleaseState {}

final class NewReleaseFailure extends NewReleaseState {
  final String errMsg;
  NewReleaseFailure(this.errMsg);
}
