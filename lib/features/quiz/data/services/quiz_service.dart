import 'package:dio/dio.dart';
import 'package:mystudy/features/quiz/data/model/quiz_data_model.dart';
import 'package:mystudy/features/quiz/data/model/quiz_model.dart';

class QuizService {
  final Dio http;



  QuizService({required this.http});

  Future<List<QuizModel>> getAllQuizzes() async {
    final response = await http.get('/quizzes');
    final List<dynamic> data = response.data;
    print('carmelle $data');
    return data.map((quiz) => QuizModel.fromJson(quiz)).toList();
  }

  Future<bool> createQuiz(QuizModel quiz) async {
    Response? response = await http.post('/add/quiz', data: quiz.toJson());
    print('carmellle ${response.statusCode}');

    return response.statusCode == 201 || response.statusCode == 200;
  }

  Future<QuizDataModel> getQuiz(int id) async {
    final response = await http.get('/quiz/$id');
    print(response.data);
    return QuizDataModel.fromJson(response.data);
  }



  Future<QuizModel> updateQuiz(int id, QuizModel question) async {
    final response = await http.put('/quiz/$id', data: question.toJson());
    return QuizModel.fromJson(response.data);
  }

  Future<void> deleteQuiz(int id) async {
    await http.delete('/quiz/$id');
  }
}
