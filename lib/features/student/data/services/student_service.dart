import 'package:dio/dio.dart';
import 'package:mystudy/features/student/data/model/student_model.dart';

class StudentService {
  final Dio http;

  StudentService({required this.http});

  Future<List<StudentModel>> getStudents() async {
    final response = await http.get('/students');
    return response.data.map((e) => StudentModel.fromJson(e)).toList();
  }

  Future<List<StudentModel>> getAllStudents() async {
    final response = await http.get('/students');
    final List<dynamic> data = response.data;
    print(data);
    return data.map((student) => StudentModel.fromJson(student)).toList();
  }

  Future<StudentModel> getStudent(int id) async {
    final response = await http.get('/students/$id');
    return StudentModel.fromJson(response.data);
  }

  Future<bool> createStudent(StudentModel student) async {
    Response response = await http.post('/students', data: student.toJson());
    return response.statusCode == 201 || response.statusCode == 200;
  }

  Future<bool> updateStudent(StudentModel student) async {
    Response response =
        await http.put('/student/update', data: student.toJson());
    return response.statusCode == 201 || response.statusCode == 200;
  }

  Future<void> deleteStudent(int id) async {
    final response = await http.delete('/students/$id');
    return response.data;
  }
}
