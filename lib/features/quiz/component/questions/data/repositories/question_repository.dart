import 'package:mystudy/features/quiz/component/answers/data/models/answer_model.dart';
import 'package:mystudy/features/quiz/component/questions/data/models/question_model.dart';
import 'package:mystudy/features/quiz/component/answers/data/services/answer_service.dart';
import 'package:mystudy/features/quiz/component/questions/data/services/question_service.dart';

class QuestionRepository {
  final QuestionService service;
  final AnswerService answerService;

  QuestionRepository({required this.service, required this.answerService});

  Future<List<QuestionModel>> getAllQuestions() async {
    return await service.getAllQuestions();
  }

  Future<QuestionModel> getQuestion(int id) async {
    return await service.getQuestion(id);
  }

  Future<void> createQuestion(QuestionModel question, List<AnswerModel> answers) async {
    await service.createQuestion(question);

    for (var answer in answers) {
      final answerWithQuestionId = AnswerModel(
        content: answer.content,
        isTrue: answer.isTrue,
        questionId: question.id,
      );

      await answerService.createAnswer(answerWithQuestionId);
    }
  }

  Future<QuestionModel> updateQuestion(int id, QuestionModel question) async {
    return await service.updateQuestion(id, question);
  }

  Future<void> deleteQuestion(int id) async {
    await service.deleteQuestion(id);
  }

  // Future<void> createQuestionWithAnswers(
  //     QuestionModel question, List<AnswerModel> answers) async {
  //   try {
  //     await createQuestion(question);

  //     for (var answer in answers) {
  //       final answerWithQuestionId = AnswerModel(
  //         content: answer.content,
  //         isTrue: answer.isTrue,
  //         questionId: question.id,
  //       );

  //       await answerService.createAnswer(answerWithQuestionId);
  //     }

  //     print("Question et réponses associées créées avec succès.");
  //   } catch (e) {
  //     print("Erreur lors de la création de la question et des réponses : $e");
  //   }
  // }
}
