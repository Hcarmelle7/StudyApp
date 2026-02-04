part of 'questions_bloc.dart';

@immutable
sealed class QuestionsState {}

final class QuestionsInitial extends QuestionsState {}

final class GetAllQuestionsLoading extends QuestionsState {}

final class GetAllQuestionsSuccess extends QuestionsState {
  final List<QuestionModel> questions;
  GetAllQuestionsSuccess(this.questions);
}

final class GetAllQuestionsFailure extends QuestionsState {
  final String message;
  GetAllQuestionsFailure(this.message);
}

final class GetQuestionLoading extends QuestionsState {}

final class GetQuestionSuccess extends QuestionsState {
  final QuestionModel question;
  GetQuestionSuccess(this.question);
}

final class GetQuestionFailure extends QuestionsState {
  final String message;
  GetQuestionFailure(this.message);
}


