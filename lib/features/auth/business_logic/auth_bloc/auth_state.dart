part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  final UserModel? user;

  const AuthState({this.user});
}

final class AuthInitial extends AuthState {}

final class FetchUsersLoading extends AuthState {}

class RegisterLoading extends AuthState {}

class RegisterSuccess extends AuthState {
  final String token;

  const RegisterSuccess(this.token);
}

class RegisterFailure extends AuthState {
  final String error;

  const RegisterFailure(this.error);
}

final class LoginLoading extends AuthState {}

final class LoginSuccess extends AuthState {
  const LoginSuccess({required user});
}

final class LoginFailure extends AuthState {
  final String message;
  const LoginFailure({required this.message});
}

final class FetchUsersSuccess extends AuthState {
  final List<UserModel> users;
  const FetchUsersSuccess(this.users);
}

final class FetchUsersFaillure extends AuthState {
  final String message;
  const FetchUsersFaillure({required this.message});
}

final class FirstTimeLaunch extends AuthState {}

final class CheckAuthStateFailure extends AuthState {}

final class CheckAuthStateSuccess extends AuthState {
  const CheckAuthStateSuccess({required super.user});
}
