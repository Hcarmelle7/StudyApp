 import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mystudy/features/quiz/component/answers/data/models/answer_model.dart';
import 'package:mystudy/features/quiz/component/answers/data/repositories/answer_repository.dart';

part 'get_answer_event.dart';
part 'get_answer_state.dart';

class GetAnswerBloc extends Bloc<GetAnswersEvent, GetAnswerState> {
  final AnswerRepository repository;

  GetAnswerBloc({required this.repository}) : super(GetAnswerInitial()) {
    on<GetAllAnswersEvent>((event, emit) async {
      emit(GetAllAnswersLoading());
      final answers = await repository.getAllAnswers();
      emit(GetAllAnswersSuccess(answers));
    });

    on<GetAnswerEvent>((event, emit) async {
      emit(GetAnswerLoading());
      final answer = await repository.getAnswer(event.id);
      emit(GetAnswerSuccess(answer));
    });

    on<GetAnswerByQuestionEvent>((event, emit) async {
      emit(GetAnswerByQuestionLoading());
      final answers = await repository.getAnswerByQuestion(event.questionId);
      emit(GetAnswerByQuestionSuccess(answers));
    });

  }
}
