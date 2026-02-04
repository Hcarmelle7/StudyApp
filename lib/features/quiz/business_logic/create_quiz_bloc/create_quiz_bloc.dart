import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mystudy/features/quiz/data/model/quiz_model.dart';
import 'package:mystudy/features/quiz/data/model/score_model.dart';
import 'package:mystudy/features/quiz/data/repositories/quiz_repository.dart';
import 'package:mystudy/features/quiz/data/repositories/score_repository.dart';
import 'package:mystudy/features/quiz/component/questions/data/models/question_model.dart';

part 'create_quiz_event.dart';
part 'create_quiz_state.dart';

class CreateQuizBloc extends Bloc<CreateQuizEvent, CreateQuizState> {
  final QuizRepository repository;
  final ScoreRepository? scoreRepository;
  CreateQuizBloc({required this.repository, this.scoreRepository})
      : super(CreateQuizInitial()) {
    on<CreateQuizzesEvent>((event, emit) async {
      try {
        emit(CreateQuizLoading());
        await repository.createQuiz(event.quiz, event.questions);
        emit(CreateQuizSuccess());
      } catch (e) {
        emit(CreateQuizFailure(e.toString()));
      }
    });

    on<CreateScoreEvent>((event, emit) async {
      try {
        emit(CreateScoreLoading());
        await scoreRepository!.createScore(event.score);
        emit(CreateScoreSuccess());
      } catch (e) {
        emit(CreateScoreFailure(e.toString()));
      }
    });
  }
}
