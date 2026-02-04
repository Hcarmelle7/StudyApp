import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mystudy/features/quiz/data/model/quiz_model.dart';
import 'package:mystudy/features/quiz/data/repositories/quiz_repository.dart';

part 'quiz_event.dart';
part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository repository;
  QuizBloc({required this.repository}) : super(QuizInitial()) {
    on<GetAllQuizzesEvent>((event, emit) async {
      try {
        print('object');

        emit(GetAllQuizzesLoading());

        final quizzes = await repository.getAllQuizzes();
        
        emit(GetAllQuizzesSuccess(quizzes));
      } catch (e) {
        emit(GetAllQuizzesFailure(e.toString()));
      }
    });
  }
}
