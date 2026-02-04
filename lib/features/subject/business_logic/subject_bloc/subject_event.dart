part of 'subject_bloc.dart';

@immutable
sealed class SubjectEvent {}

class GetAllSubjectEvent extends SubjectEvent{}