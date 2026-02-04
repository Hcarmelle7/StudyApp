part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class GetCurrentUserLoading extends ProfileState{}

final class GetCurrentUserSuccess extends ProfileState {
  final UserModel user;
   GetCurrentUserSuccess(this.user);
}

final class GetCurrentUsersFailure extends ProfileState {
  final String message;
   GetCurrentUsersFailure({required this.message});
}