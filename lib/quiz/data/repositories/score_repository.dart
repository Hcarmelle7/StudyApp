import 'package:mystudy/quiz/data/model/score_model.dart';
import 'package:mystudy/quiz/data/services/score_service.dart';

class ScoreRepository {
  final ScoreService service;

  ScoreRepository({required this.service});

  Future<bool> createScore(ScoreModel score) async {
    if (await service.createScore(score)) return false;
    return true;
  }

  Future<List<ScoreModel>> getAllScores() async {
    return await service.getAllScores();
  }
}
