part of 'create_classes_bloc.dart';

@immutable
sealed class CreateClassesState {}

final class CreateClassesInitial extends CreateClassesState {}

final class CreateClasseLoading extends CreateClassesState {}

final class CreateClasseSuccess extends CreateClassesState {
  final ClasseModel classe;
  CreateClasseSuccess(this.classe);
}

final class CreateClasseFailure extends CreateClassesState {
  final String message;
  CreateClasseFailure({required this.message});
}