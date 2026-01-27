import 'package:mystudy/quiz/answers/data/models/answer_model.dart';
import 'package:mystudy/quiz/answers/data/services/Answer_service.dart';

class AnswerRepository {
  final AnswerService service;

  AnswerRepository({required this.service});

  Future<List<AnswerModel>> getAllAnswers() async {
    return await service.getAllAnswers();
  }

  Future<AnswerModel> getAnswer(int id) async {
    return await service.getAnswer(id);
  }

  Future<List<AnswerModel>> getAnswerByQuestion(int? id) async {
    return await service.getAnswerByQuestion(id);
  }

  Future<AnswerModel> createAnswer(AnswerModel answer) async {
    return await service.createAnswer(answer);
  }

  Future<AnswerModel> updateAnswer(int id, AnswerModel Answer) async {
    return await service.updateAnswer(id, Answer);
  }

  Future<void> deleteAnswer(int id) async {
    await service.deleteAnswer(id);
  }
}
