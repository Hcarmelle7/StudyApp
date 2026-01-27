part of 'get_classes_bloc.dart';

@immutable
sealed class GetClassesState {}

final class GetClassesInitial extends GetClassesState {}

final class GetAllClassesLoading extends GetClassesState {}

final class GetAllClassesFailure extends GetClassesState {
  final String message;
  GetAllClassesFailure(this.message);
}

final class GetAllClassesSuccess extends GetClassesState {
  final List<ClasseModel> classes;
  GetAllClassesSuccess(this.classes);
}