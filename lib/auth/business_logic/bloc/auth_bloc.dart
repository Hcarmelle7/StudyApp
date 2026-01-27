// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:mystudy/auth/data/model/user_model.dart';
import 'package:mystudy/auth/data/repositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;
  AuthBloc({required this.repository}) : super(AuthInitial()) {
    on<RegisterEvent>((event, emit) async {
      try {
        emit(RegisterLoading());
        await repository.register(event.user);
        emit(const RegisterSuccess('registered successfully'));
      } catch (e) {
        emit(RegisterFailure(e.toString()));
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(LoginLoading());

      try {
        final bool user = await repository.login(
          email: event.email,
          password: event.password,
        );

        if (user) {
          emit(LoginSuccess(user: user as UserModel));
        } else {
          emit(const LoginFailure(
            message: 'Email ou mot de passe incorrect',
          ));
        }
      } catch (e) {
        emit(const LoginFailure(
          message: 'Erreur serveur, veuillez réessayer',
        ));
      }
    });

    on<GetUserEvent>((event, emit) async {
      try {
        emit(FetchUsersLoading());

        final users = await repository.getAllUsers();
        emit(FetchUsersSuccess(users));
      } catch (e) {
        emit(FetchUsersFaillure(message: e.toString()));
      }
    });

    on<CheckAuthStateEvent>((event, emit) async {
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        bool? isFirsTime = prefs.getBool('is_first_time_launch');
        isFirsTime ??= false;
        print(isFirsTime);
        if (isFirsTime) {
          // var user = await repository.getCurrentUser();
          String? token = prefs.getString('token');
          token ??= '';

          if (token.isNotEmpty) {
            var user = await repository.getCurrentUser();
            emit(CheckAuthStateSuccess(user: user));
          } else {
            print('token here: $token');
            emit(CheckAuthStateFailure());
          }

          return;
        }

        emit(FirstTimeLaunch());
      } catch (e) {
        emit(CheckAuthStateFailure());
      }
    });
  }
}
