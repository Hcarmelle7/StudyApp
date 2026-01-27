part of 'create_quiz_bloc.dart';

@immutable
sealed class CreateQuizState {}

final class CreateQuizInitial extends CreateQuizState {}

final class CreateQuizLoading extends CreateQuizState {}

final class CreateQuizSuccess extends CreateQuizState {
  CreateQuizSuccess();
}

final class CreateQuizFailure extends CreateQuizState {
  final String message;
  CreateQuizFailure(this.message);
}

final class CreateScoreSuccess extends CreateQuizState {
  CreateScoreSuccess();
}

final class CreateScoreFailure extends CreateQuizState {
  final String message;
  CreateScoreFailure(this.message);
}

final class CreateScoreLoading extends CreateQuizState {}
