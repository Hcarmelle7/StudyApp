import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mystudy/quiz/answers/data/models/answer_model.dart';
import 'package:mystudy/quiz/answers/data/repositories/answer_repository.dart';

part 'create_answer_event.dart';
part 'create_answer_state.dart';

class CreateAnswerBloc extends Bloc<CreateAnswersEvent, CreateAnswerState> {
  final AnswerRepository repository;

  CreateAnswerBloc({required this.repository}) : super(CreateAnswerInitial()) {
   
    on<CreateAnswerEvent>((event, emit) async {
      emit(CreateAnswerLoading());
      final answer = await repository.createAnswer(event.answer);
      emit(CreateAnswerSuccess(answer));
    });

    on<UpdateAnswerEvent>((event, emit) async {
      emit(UpdateAnswerLoading());
      final answer =
          await repository.updateAnswer(event.id, event.answer);
      emit(UpdateAnswerSuccess(answer));
    });

    on<DeleteAnswerEvent>((event, emit) async {
      emit(DeleteAnswerLoading());
      await repository.deleteAnswer(event.id);
      emit(DeleteAnswerSuccess());
    });
  }
}
