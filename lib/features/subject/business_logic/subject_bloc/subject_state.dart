part of 'subject_bloc.dart';

@immutable
sealed class SubjectState {}

final class SubjectInitial extends SubjectState {}

final class GetAllSubjectsSuccess extends SubjectState {
  final List<SubjectModel> subject;
  GetAllSubjectsSuccess( this.subject);
}

final class GetAllSubjectsFailure extends SubjectState {
  final String message;
  GetAllSubjectsFailure({required this.message});
}

final class GetAllSubjectsLoading extends SubjectState {}

final class CreateSubjectLoading extends SubjectState {}
final class CreateSubjectSuccess extends SubjectState {
  final SubjectModel subject;
  CreateSubjectSuccess(this.subject);
}