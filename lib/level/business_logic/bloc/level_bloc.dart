import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mystudy/level/data/models/level_model.dart';
import 'package:mystudy/level/data/repositories/level_repository.dart';

part 'level_event.dart';
part 'level_state.dart';

class LevelBloc extends Bloc<LevelEvent, LevelState> {
  final LevelRepository repository;
  LevelBloc({required this.repository}) : super(LevelInitial()) {
    on<GetAllLevelsEvent>((event, emit) async {
      emit(GetAllLevelsLoading());
      try {
        final level = await repository.getAllLevels();
        emit(GetAllLevelsSuccess(level));
      } catch (e) {
        emit(GetAllLevelsFailure(message: e.toString()));
      }
    });
    on<CreateLevelEvent>((event, emit) async {
      emit(CreateLevelLoading());
      try {
        final level = await repository.createLevel(event.level);
        emit(CreateLevelSuccess(level));
      } catch (e) {
        emit(CreateLevelFailure(message: e.toString()));
      }
    });
  }
}
