import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mystudy/features/auth/data/model/user_model.dart';
import 'package:mystudy/features/auth/data/repositories/auth_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
   final AuthRepository repository;
  ProfileBloc({required this.repository}) : super(ProfileInitial()) {
   on<GetCurrentUserEvent>((event, emit) async {
      try {
        emit(GetCurrentUserLoading());

        final user = await repository.getCurrentUser();
        emit(GetCurrentUserSuccess(user));
      } catch (e) {
        emit(GetCurrentUsersFailure(message: e.toString()));
      }
    });
  }
}
