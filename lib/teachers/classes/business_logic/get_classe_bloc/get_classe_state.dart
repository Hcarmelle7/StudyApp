part of 'get_classe_bloc.dart';

@immutable
sealed class GetClasseState {}

final class GetClasseInitial extends GetClasseState {}

final class GetClasseByIdLoading extends GetClasseState {}

final class GetClasseByIdFailure extends GetClasseState {
  final String message;
  GetClasseByIdFailure(this.message);
}

final class GetClasseByIdSuccess extends GetClasseState {
  final ClasseModel classe;
  GetClasseByIdSuccess(this.classe);
}

