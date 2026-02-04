import 'package:dio/dio.dart';
import 'package:mystudy/features/quiz/component/answers/data/models/answer_model.dart';

class AnswerService {
  final Dio http;

  AnswerService({required this.http});

  Future<List<AnswerModel>> getAllAnswers() async {
    final response = await http.get('/answers');
    final List<dynamic> data = response.data;
    print(data);
    return data.map((answer) => AnswerModel.fromJson(answer)).toList();
  }

  Future<AnswerModel> getAnswer(int id) async {
    final response = await http.get('/answers/$id');
    return AnswerModel.fromJson(response.data);
  }

  Future<List<AnswerModel>> getAnswerByQuestion(int? id) async {
    final response = await http.get('/answer/$id');
    final List<dynamic> data = response.data;
    return data.map((answer) => AnswerModel.fromJson(answer)).toList();
  }

  Future<AnswerModel> createAnswer(AnswerModel answer) async {
    final response = await http.post('/add/answer', data: answer.toJson());
    return AnswerModel.fromJson(response.data);
  }

  Future<AnswerModel> updateAnswer(int id, AnswerModel answer) async {
    final response = await http.put('/answers/$id', data: answer.toJson());
    return AnswerModel.fromJson(response.data);
  }

  Future<void> deleteAnswer(int id) async {
    await http.delete('/answers/$id');
  }
}
