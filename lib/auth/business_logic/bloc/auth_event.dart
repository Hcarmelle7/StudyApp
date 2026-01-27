part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class GetUserEvent extends AuthEvent {}

class RegisterEvent extends AuthEvent {
  final UserModel user;

  RegisterEvent(this.user);
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class CheckAuthStateEvent extends AuthEvent {}

