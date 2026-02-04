import 'package:mystudy/features/student/data/model/student_model.dart';
import 'package:mystudy/features/student/data/services/student_service.dart';

class StudentRepository {
  final StudentService service;

  StudentRepository({
    required this.service,
  });

  // Future<List<StudentModel>> getStudents() async {
  //   final response = await service.getStudents();
  //   return response.map((e) => StudentModel.fromJson(e as Map<String, dynamic>)).toList();
  // } 

  Future<List<StudentModel>> getAllStudents() async {
    return await service.getAllStudents();
  }

  Future<StudentModel> getStudent(int id) async {
    return await service.getStudent(id);
  }

  Future<bool> createStudent(StudentModel student) async {
    return await service.createStudent(student);
  } 

  Future<bool> updateStudent( StudentModel student) async {
    return await service.updateStudent(student);
  }

  Future<void> deleteStudent(int id) async {
    return await service.deleteStudent(id);
  }
}
