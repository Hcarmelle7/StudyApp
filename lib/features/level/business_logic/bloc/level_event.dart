part of 'level_bloc.dart';

@immutable
sealed class LevelEvent {}

class GetAllLevelsEvent extends LevelEvent {}

class GetLevelEvent extends LevelEvent {
  final int id;
  GetLevelEvent({required this.id});
}

class CreateLevelEvent extends LevelEvent {
  final LevelModel level;
  CreateLevelEvent( this.level);
}

class UpdateLevelEvent extends LevelEvent {
  final int id;
  final LevelModel level;
  UpdateLevelEvent({required this.id, required this.level});
}

class DeleteLevelEvent extends LevelEvent {
  final int id;
  DeleteLevelEvent({required this.id});
}
