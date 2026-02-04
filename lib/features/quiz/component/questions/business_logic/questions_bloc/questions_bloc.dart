import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mystudy/features/quiz/component/questions/data/models/question_model.dart';
import 'package:mystudy/features/quiz/component/questions/data/repositories/question_repository.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final QuestionRepository repository;
  QuestionsBloc({required this.repository}) : super(QuestionsInitial()) {
    on<GetAllQuestionsEvent>((event, emit) async {
      try {
        emit(GetAllQuestionsLoading());
        final questions = await repository.getAllQuestions();
        emit(GetAllQuestionsSuccess(questions));
      } catch (e) {
        emit(GetAllQuestionsFailure(e.toString()));
      }
    });

    on<GetQuestionEvent>((event, emit) async {
      try {
        emit(GetQuestionLoading());
        final question = await repository.getQuestion(event.id);
        emit(GetQuestionSuccess(question));
      } catch (e) {
        emit(GetQuestionFailure(e.toString()));
      }
    });
  }
}
