part of 'score_bloc.dart';

@immutable
sealed class ScoreState {}

final class ScoreInitial extends ScoreState {}

final class GetAllScoresSuccess extends ScoreState {
  final List<ScoreModel> score;
  GetAllScoresSuccess( this.score);
}

final class GetAllScoresFailure extends ScoreState {
  final String message;
  GetAllScoresFailure({required this.message});
}

final class GetAllScoresLoading extends ScoreState {}