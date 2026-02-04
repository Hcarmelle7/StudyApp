part of 'level_bloc.dart';

@immutable
sealed class LevelState {}

final class LevelInitial extends LevelState {}

final class LevelLoading extends LevelState {}

final class LevelSuccess extends LevelState {}

final class LevelFailure extends LevelState {}

final class GetAllLevelsSuccess extends LevelState {
  final List<LevelModel> level;
  GetAllLevelsSuccess( this.level);
}

final class GetAllLevelsFailure extends LevelState {
  final String message;
  GetAllLevelsFailure({required this.message});
}

final class GetAllLevelsLoading extends LevelState {}

final class CreateLevelLoading extends LevelState {}
final class CreateLevelSuccess extends LevelState {
  final LevelModel level;
  CreateLevelSuccess(this.level);
}

final class CreateLevelFailure extends LevelState {
  final String message;
  CreateLevelFailure({required this.message});
}
