import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mystudy/quiz/data/model/score_model.dart';
import 'package:mystudy/quiz/data/repositories/score_repository.dart';

part 'score_event.dart';
part 'score_state.dart';

class ScoreBloc extends Bloc<ScoreEvent, ScoreState> {
  final ScoreRepository repository;
  ScoreBloc({required this.repository}) : super(ScoreInitial()) {
    on<GetAllScoresEvent>((event, emit) async {
      emit(GetAllScoresLoading());
      try {
        final score = await repository.getAllScores();
        emit(GetAllScoresSuccess(score));
      } catch (e) {
        emit(GetAllScoresFailure(message: e.toString()));
      }
    });
  }
}
