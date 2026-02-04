part of 'questions_bloc.dart';

@immutable
sealed class QuestionsEvent {}

class GetAllQuestionsEvent extends QuestionsEvent {}

class GetQuestionEvent extends QuestionsEvent {
  final int id;
  GetQuestionEvent({required this.id});
}



