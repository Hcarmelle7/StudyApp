part of 'create_quiz_bloc.dart';

@immutable
sealed class CreateQuizEvent {}

class CreateQuizzesEvent extends CreateQuizEvent {
  final QuizModel quiz;
  final List<QuestionModel> questions;

  CreateQuizzesEvent(this.quiz, this.questions);
}

class CreateScoreEvent extends CreateQuizEvent {
  final ScoreModel score;
  CreateScoreEvent(this.score);
}
