part of 'score_bloc.dart';

@immutable
sealed class ScoreEvent {}

class GetAllScoresEvent extends ScoreEvent {}