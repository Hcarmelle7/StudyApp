import 'package:dio/dio.dart';
import 'package:mystudy/features/level/data/models/level_model.dart';

class LevelService {
  final Dio http;

  LevelService({required this.http});

  Future<List<LevelModel>> getLevels() async {
    final response = await http.get('/levels');
    return response.data.map((e) => LevelModel.fromJson(e)).toList();
  }

  Future<List<LevelModel>> getAllLevels() async {
    final response = await http.get('/levels');
    final List<dynamic> data = response.data;
    print(data);
    return data.map((student) => LevelModel.fromJson(student)).toList();
  }

  Future<LevelModel> getLevel(int id) async {
    final response = await http.get('/levels/$id');
    return LevelModel.fromJson(response.data);
  }

  Future<LevelModel> createLevel(LevelModel level) async {
    final response = await http.post('/add/level', data: level.toJson());
    return LevelModel.fromJson(response.data);
  }

  Future<void> updateLevel(int id, LevelModel level) async {
    final response = await http.put('/levels/$id', data: level.toJson());
    return response.data;
  }

  Future<void> deleteLevel(int id) async {
    final response = await http.delete('/levels/$id');
    return response.data;
  }
}
