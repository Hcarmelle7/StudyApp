import 'package:dio/dio.dart';
import 'package:mystudy/subject/data/models/subject_model.dart';

class SubjectService {
  final Dio http;

  SubjectService({required this.http});

  Future<List<SubjectModel>> getAllSubjects() async {
    final response = await http.get('/subjects');
    final List<dynamic> data = response.data;

    return data.map((subject) => SubjectModel.fromJson(subject)).toList();
  }

//  Future<List<LevelModel>> getAllLevels() async {
//     final response = await http.get('/levels');
//     final List<dynamic> data = response.data;
//     print(data);
//     return data.map((student) => LevelModel.fromJson(student)).toList();
//   }
  Future<SubjectModel> createSubject(SubjectModel sub) async {
    final response = await http.post('/add/subject', data: sub.toJson());
    return SubjectModel.fromJson(response.data);
  }

  Future<void> updateSubject(int id, SubjectModel sub) async {
    final response = await http.put('/subject/$id', data: sub.toJson());
    return response.data;
  }

  Future<void> deleteSubject(int id) async {
    final response = await http.delete('/subject/$id');
    return response.data;
  }
}
