import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:mystudy/features/quiz/component/answers/data/models/answer_model.dart';
import 'package:mystudy/features/quiz/component/questions/data/models/question_model.dart';
import 'package:mystudy/features/quiz/component/questions/data/repositories/question_repository.dart';

part 'create_question_event.dart';
part 'create_question_state.dart';

class CreateQuestionBloc
    extends Bloc<CreateQuestionEvent, CreateQuestionState> {
  final QuestionRepository repository;
  CreateQuestionBloc({required this.repository})
      : super(CreateQuestionInitial()) {
    on<CreateQuestionsEvent>((event, emit) async {
      try {
        emit(CreateQuestionLoading());
        await repository.createQuestion(event.question, event.answers);
        emit(CreateQuestionSuccess());
      } catch (e) {
        emit(CreateQuestionFailure(e.toString()));
      }
    });

    on<UpdateQuestionEvent>((event, emit) async {
      try {
        emit(UpdateQuestionLoading());
        final question =
            await repository.updateQuestion(event.id, event.question);
        emit(UpdateQuestionSuccess(question));
      } catch (e) {
        emit(UpdateQuestionFailure(e.toString()));
      }
    });

    on<DeleteQuestionEvent>((event, emit) async {
      try {
        emit(DeleteQuestionLoading());
        await repository.deleteQuestion(event.id);
        emit(DeleteQuestionSuccess());
      } catch (e) {
        emit(DeleteQuestionFailure(e.toString()));
      }
    });
  }
}
