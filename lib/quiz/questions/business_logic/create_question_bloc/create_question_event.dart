part of 'create_question_bloc.dart';

@immutable
sealed class CreateQuestionEvent {}

class CreateQuestionsEvent extends CreateQuestionEvent {
  final QuestionModel question;
  final List<AnswerModel> answers;
  CreateQuestionsEvent(this.question, this.answers);
}

class UpdateQuestionEvent extends CreateQuestionEvent {
  final int id;
  final QuestionModel question;
  UpdateQuestionEvent(this.id, this.question);
}

class DeleteQuestionEvent extends CreateQuestionEvent {
  final int id;
  DeleteQuestionEvent(this.id);
}
