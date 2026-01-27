part of 'student_bloc.dart';

@immutable
sealed class StudentEvent {}

class GetAllStudentsEvent extends StudentEvent {}

class GetStudentEvent extends StudentEvent {
  final int id;
  GetStudentEvent(this.id);
}

class CreateStudentEvent extends StudentEvent {
  final StudentModel student;
  CreateStudentEvent(this.student);
}

class UpdateStudentEvent extends StudentEvent {
  final StudentModel student;
  UpdateStudentEvent(this.student);
}

class DeleteStudentEvent extends StudentEvent {
  final int id;
  DeleteStudentEvent(this.id);
}
