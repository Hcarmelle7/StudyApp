import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mystudy/features/student/data/model/student_model.dart';
import 'package:mystudy/features/student/data/repositories/student_repository.dart';

part 'student_event.dart';
part 'student_state.dart';

class StudentBloc extends Bloc<StudentEvent, StudentState> {
  final StudentRepository repository;
  StudentBloc({required this.repository}) : super(StudentInitial()) {
 

    on<GetAllStudentsEvent>((event, emit) async {
      emit(FetchStudentsLoading());

      final students = await repository.getAllStudents();

      emit(FetchStudentsSuccess(students));
    });

    on<GetStudentEvent>((event, emit) async {
      try {
        emit(FetchStudentLoading());

        final student = await repository.getStudent(event.id);

        emit(FetchStudentSuccess(student));
      } catch (e) {
        emit(FetchStudentFailure(e.toString()));
      }
    });

    on<CreateStudentEvent>((event, emit) async {
      try {
        emit(CreateStudentLoading());

        await repository.createStudent(event.student);
        emit(const CreateStudentSuccess());
      } catch (e) {
        emit(CreateStudentFailure(e.toString()));
      }
    });

    on<UpdateStudentEvent>((event, emit) async {
      try {
        emit(UpdateStudentLoading());

        await repository.updateStudent( event.student);
        emit(const UpdateStudentSuccess());
      } catch (e) {
        emit(UpdateStudentFailure(e.toString()));
      }
    });

    on<DeleteStudentEvent>((event, emit) async {
      try {
        emit(DeleteStudentLoading());

        await repository.deleteStudent(event.id);
        emit(DeleteStudentSuccess());
      } catch (e) {
        emit(DeleteStudentFailure(e.toString()));
      }
    });
  }
}
