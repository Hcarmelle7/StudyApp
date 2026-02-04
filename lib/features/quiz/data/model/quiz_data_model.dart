import 'package:mystudy/features/quiz/data/model/quiz_model.dart';
import 'package:mystudy/features/quiz/component/questions/data/models/question_model.dart';

class QuizDataModel {
  final QuizModel quiz;
  final List<QuestionModel> questions;

  QuizDataModel({required this.quiz, required this.questions});

  factory QuizDataModel.fromJson(Map<String, dynamic> json) {
    return QuizDataModel(
      quiz: QuizModel.fromJson(json['quiz']),
      questions: (json['questions'] as List)
          .map((questionJson) =>
              QuestionModel.fromJson(questionJson as Map<String, dynamic>))
          .toList(),
      // questions: json['questions'] != null
      //     ? (json['questions'])
      //         .map((question) => QuestionModel.fromJson(question))
      //         .toList()
      //     : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quiz': quiz.toJson(),
      'questions': questions.map((question) => question.toJson()).toList(),
    };
  }
}
