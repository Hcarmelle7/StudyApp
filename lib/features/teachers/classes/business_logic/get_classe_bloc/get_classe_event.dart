part of 'get_classe_bloc.dart';

@immutable
sealed class GetClasseEvent {}

class GetClasseByIdEvent extends GetClasseEvent {
  final int id;
  GetClasseByIdEvent({required this.id});
}