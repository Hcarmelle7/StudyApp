import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mystudy/quiz/data/model/quiz_data_model.dart';
import 'package:mystudy/quiz/data/repositories/quiz_repository.dart';

part 'quiz_by_id_event.dart';
part 'quiz_by_id_state.dart';

class QuizByIdBloc extends Bloc<QuizByIdEvent, QuizByIdState> {
  final QuizRepository repository;
  QuizByIdBloc({required this.repository}) : super(QuizByIdInitial()) {

    on<GetQuizEvent>((event, emit) async {
      try {
        emit(GetQuizLoading());
        final quiz = await repository.getQuiz(event.id);
        emit(GetQuizSuccess(quiz));
      } catch (e) {
        emit(GetQuizFailure(e.toString()));
      }
    });
  }
}
