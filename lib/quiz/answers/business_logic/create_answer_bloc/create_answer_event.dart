part of 'create_answer_bloc.dart';

@immutable
sealed class CreateAnswersEvent {}


class CreateAnswerEvent extends CreateAnswersEvent {
  final AnswerModel answer;
  CreateAnswerEvent(this.answer);
}


class UpdateAnswerEvent extends CreateAnswersEvent {
  final int id;
  final AnswerModel answer;
  UpdateAnswerEvent(this.id, this.answer);
}

class DeleteAnswerEvent extends CreateAnswersEvent {
  final int id;
  DeleteAnswerEvent(this.id);
}
