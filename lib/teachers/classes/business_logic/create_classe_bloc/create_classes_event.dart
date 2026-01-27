part of 'create_classes_bloc.dart';

@immutable
sealed class CreateClassesEvent {}

class CreateClasseEvent extends CreateClassesEvent {
  final ClasseModel classe;
  CreateClasseEvent( this.classe);
}

class UpdateClasseEvent extends CreateClassesEvent {
  final int id;
  final ClasseModel classe;
  UpdateClasseEvent({required this.id, required this.classe});
}

class DeleteClasseEvent extends CreateClassesEvent {
  final int id;
  DeleteClasseEvent({required this.id});
}