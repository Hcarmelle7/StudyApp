import 'package:mystudy/features/quiz/component/questions/data/models/question_model.dart';

class QuizModel {
  final int id;
  final String title;
  final String description;
  final int? nQuestions;
  List<QuestionModel> questions;

  QuizModel(
      {required this.id,
      required this.title,
      required this.description,
      this.nQuestions,
      required this.questions});

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      nQuestions: json['Nquestions'],
      questions: json['questions'] != null
          ? (json['questions'])
              .map((question) => QuestionModel.fromJson(question))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'title': title,
      'n_question': nQuestions,
      'questions': questions.map((question) => question.toJson()).toList()
    };
  }
}
