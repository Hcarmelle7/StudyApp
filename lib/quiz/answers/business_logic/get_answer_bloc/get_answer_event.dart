part of 'get_answer_bloc.dart';

@immutable
sealed class GetAnswersEvent {}

class GetAllAnswersEvent extends GetAnswersEvent {}

class GetAnswerEvent extends GetAnswersEvent {
  final int id;
  GetAnswerEvent({required this.id});
}

class GetAnswerByQuestionEvent extends GetAnswersEvent {
  final int? questionId;
  GetAnswerByQuestionEvent({this.questionId});
}

