part of 'student_bloc.dart';

@immutable
sealed class StudentState {
  final StudentModel? student;

  const StudentState({this.student});
}

final class StudentInitial extends StudentState {}

final class FetchStudentsLoading extends StudentState {}

final class FetchStudentsSuccess extends StudentState {
  final List<StudentModel> students;

  const FetchStudentsSuccess(this.students);
}

final class FetchStudentsFailure extends StudentState {
  final String error;

  const FetchStudentsFailure({required this.error});
}

final class FetchStudentLoading extends StudentState {}

final class FetchStudentSuccess extends StudentState {
  @override
  // ignore: overridden_fields
  final StudentModel student;
  const FetchStudentSuccess(this.student);
} 

final class FetchStudentFailure extends StudentState {
  final String error;
  const FetchStudentFailure( this.error);
}

final class CreateStudentLoading extends StudentState {}

final class CreateStudentSuccess extends StudentState {
  const CreateStudentSuccess();
}

final class CreateStudentFailure extends StudentState {
  final String error;
  const CreateStudentFailure( this.error);
}

final class UpdateStudentLoading extends StudentState {}

final class UpdateStudentSuccess extends StudentState {
  const UpdateStudentSuccess();
}

final class UpdateStudentFailure extends StudentState {
  final String error;
  const UpdateStudentFailure( this.error);
}

final class DeleteStudentLoading extends StudentState {}

final class DeleteStudentSuccess extends StudentState {}

final class DeleteStudentFailure extends StudentState {
  final String error;
  const DeleteStudentFailure(this.error);
}
