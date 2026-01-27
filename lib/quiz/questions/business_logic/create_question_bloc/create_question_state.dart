part of 'create_question_bloc.dart';

@immutable
sealed class CreateQuestionState {}

final class CreateQuestionInitial extends CreateQuestionState {}

final class CreateQuestionLoading extends CreateQuestionState {}

final class CreateQuestionSuccess extends CreateQuestionState {
  CreateQuestionSuccess();
}

final class CreateQuestionFailure extends CreateQuestionState {
  final String message;
  CreateQuestionFailure(this.message);
}

final class UpdateQuestionLoading extends CreateQuestionState {}

final class UpdateQuestionSuccess extends CreateQuestionState {
  final QuestionModel question;
  UpdateQuestionSuccess(this.question);
}

final class UpdateQuestionFailure extends CreateQuestionState {
  final String message;
  UpdateQuestionFailure(this.message);
}

final class DeleteQuestionLoading extends CreateQuestionState {}

final class DeleteQuestionSuccess extends CreateQuestionState {}

final class DeleteQuestionFailure extends CreateQuestionState {
  final String message;
  DeleteQuestionFailure(this.message);
}
