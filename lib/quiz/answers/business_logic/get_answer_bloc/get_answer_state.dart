part of 'get_answer_bloc.dart';


@immutable
sealed class GetAnswerState {}

final class GetAnswerInitial extends GetAnswerState {}


final class GetAllAnswersLoading extends GetAnswerState {}

final class GetAllAnswersSuccess extends GetAnswerState {
  final List<AnswerModel> answers;
  GetAllAnswersSuccess(this.answers);
} 

final class GetAllAnswersFailure extends GetAnswerState {
  final String message;
  GetAllAnswersFailure(this.message);
}

final class GetAnswerLoading extends GetAnswerState {}

final class GetAnswerSuccess extends GetAnswerState {
  final AnswerModel answer;
  GetAnswerSuccess(this.answer);
} 

final class GetAnswerFailure extends GetAnswerState {
  final String message;
  GetAnswerFailure(this.message);
} 

final class GetAnswerByQuestionLoading extends GetAnswerState {}

final class GetAnswerByQuestionSuccess extends GetAnswerState {
  final List<AnswerModel> answers;
  GetAnswerByQuestionSuccess(this.answers);
} 

final class GetAnswerByQuestionFailure extends GetAnswerState {
  final String message;
  GetAnswerByQuestionFailure(this.message);
} 

