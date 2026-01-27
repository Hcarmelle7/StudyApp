part of 'quiz_by_id_bloc.dart';

@immutable
sealed class QuizByIdState {}

final class QuizByIdInitial extends QuizByIdState {}

final class GetQuizLoading extends QuizByIdState {}

final class GetQuizFailure extends QuizByIdState {
  final String message;
  GetQuizFailure(this.message);
}

final class GetQuizSuccess extends QuizByIdState {
  final QuizDataModel quiz;
  GetQuizSuccess(this.quiz);
}
