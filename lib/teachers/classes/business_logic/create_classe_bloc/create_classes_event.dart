part of 'create_classes_bloc.dart';

@immutable
sealed class CreateClassesEvent {}

class CreateClasseEvent extends CreateClassesEvent {
  final ClasseModel Classe;
  CreateClasseEvent( this.Classe);
}

class UpdateClasseEvent extends CreateClassesEvent {
  final int id;
  final ClasseModel Classe;
  UpdateClasseEvent({required this.id, required this.Classe});
}

class DeleteClasseEvent extends CreateClassesEvent {
  final int id;
  DeleteClasseEvent({required this.id});
}