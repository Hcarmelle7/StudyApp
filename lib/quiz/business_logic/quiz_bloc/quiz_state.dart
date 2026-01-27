part of 'quiz_bloc.dart';

@immutable
sealed class QuizState {}

final class QuizInitial extends QuizState {}

final class GetAllQuizzesLoading extends QuizState {}

final class GetAllQuizzesFailure extends QuizState {
  final String message;
  GetAllQuizzesFailure(this.message);
}

final class GetAllQuizzesSuccess extends QuizState {
  final List<QuizModel> quizzes;
  GetAllQuizzesSuccess(this.quizzes);
}


