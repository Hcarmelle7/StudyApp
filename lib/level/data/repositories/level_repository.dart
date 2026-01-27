import 'package:mystudy/level/data/models/level_model.dart';
import 'package:mystudy/level/data/services/level_service.dart';

class LevelRepository {
  final LevelService service;

  LevelRepository({
    required this.service,
  });

  // Future<List<StudentModel>> getStudents() async {
  //   final response = await service.getStudents();
  //   return response.map((e) => StudentModel.fromJson(e as Map<String, dynamic>)).toList();
  // } 

  Future<List<LevelModel>> getAllLevels() async {
    return await service.getAllLevels();
  }

  Future<LevelModel> getLevel(int id) async {
    return await service.getLevel(id);
  }

  Future<LevelModel> createLevel(LevelModel level) async {
    return await service.createLevel(level);
  } 

  Future<void> updateLevel(int id, LevelModel level) async {
    return await service.updateLevel(id, level);
  }

  Future<void> deleteLevel(int id) async {
    return await service.deleteLevel(id);
  }
}
