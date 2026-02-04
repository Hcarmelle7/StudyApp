import 'package:dio/dio.dart';
import 'package:mystudy/features/quiz/component/questions/data/models/question_model.dart';

class QuestionService {
  final Dio http;

  QuestionService({required this.http});

  Future<List<QuestionModel>> getAllQuestions() async {
    final response = await http.get('/questions');
    final List<dynamic> data = response.data;
    print(data);
    return data.map((question) => QuestionModel.fromJson(question)).toList();
  }

  Future<QuestionModel> getQuestion(int id) async {
    final response = await http.get('/questions/$id');
    return QuestionModel.fromJson(response.data);
  }

  Future<bool> createQuestion(QuestionModel question) async {
    Response response = await http.post('/add/question', data: question.toJson());
    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<QuestionModel> updateQuestion(int id, QuestionModel question) async {
    final response = await http.put('/questions/$id', data: question.toJson());
    return QuestionModel.fromJson(response.data);
  }

  Future<void> deleteQuestion(int id) async {
    await http.delete('/questions/$id');
  }
}
