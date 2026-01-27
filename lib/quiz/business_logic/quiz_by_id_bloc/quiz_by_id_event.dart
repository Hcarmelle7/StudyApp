part of 'quiz_by_id_bloc.dart';

@immutable
sealed class QuizByIdEvent {}

class GetQuizEvent extends QuizByIdEvent {
  final int id;
  GetQuizEvent({required this.id});
}
