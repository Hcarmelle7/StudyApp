import 'package:mystudy/quiz/data/model/quiz_data_model.dart';
import 'package:mystudy/quiz/data/model/quiz_model.dart';
import 'package:mystudy/quiz/data/services/quiz_service.dart';
import 'package:mystudy/quiz/questions/data/models/question_model.dart';
import 'package:mystudy/quiz/questions/data/services/question_service.dart';

class QuizRepository {
  final QuizService service;
  final QuestionService questionService;

  QuizRepository({
    required this.service,
    required this.questionService,
  });

  Future<List<QuizModel>> getAllQuizzes() async {
    return await service.getAllQuizzes();
  }

  Future<QuizDataModel> getQuiz(int id) async {
    return await service.getQuiz(id);
  }

  Future<bool> createQuiz(QuizModel quiz, List<QuestionModel> questions) async {
    if (await service.createQuiz(quiz)) return false;

    for (var question in questions) {
      final questionWithQuizId = QuestionModel(
        content: question.content,
        type: question.type,
        level: question.level,
        duration: question.duration,
        answers: question.answers,
      );

      await questionService.createQuestion(questionWithQuizId);
    }

    return true;
  }

  Future<QuizModel> updateQuiz(int id, QuizModel quiz) async {
    return await service.updateQuiz(id, quiz);
  }

  Future<void> deleteQuiz(int id) async {
    await service.deleteQuiz(id);
  }
}
