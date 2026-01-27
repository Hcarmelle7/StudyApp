import 'package:dio/dio.dart';
import 'package:mystudy/quiz/data/model/score_model.dart';

class ScoreService {
  final Dio http;

  ScoreService({required this.http});

   Future<bool> createScore(ScoreModel score) async {
    Response? response = await http.post('/add/score', data: score.toJson());
    print('score ${response.statusCode}');

    return response.statusCode == 201 || response.statusCode == 200;
  }

  Future<List<ScoreModel>> getAllScores() async {
      final response = await http.get('/Scores');
      final List<dynamic> data = response.data;
      print(data);
      return data.map((student) => ScoreModel.fromJson(student)).toList();
  }
}
