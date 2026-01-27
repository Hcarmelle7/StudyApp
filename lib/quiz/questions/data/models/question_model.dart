import 'package:mystudy/quiz/answers/data/models/answer_model.dart';

class QuestionModel {
  final int? id;
  final String content;
  final String type;
  final String level;
  final String duration;
  final int? teacherId;
  final List<AnswerModel> answers;

  QuestionModel({
    this.id,
    required this.content,
    required this.type,
    required this.level,
    required this.duration,
    this.teacherId,
    required this.answers,
  });

  // Méthode pour convertir le JSON en objet Dart
  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    print('RAW answers: ${json['answers']}');
    print('TYPE answers: ${json['answers']?.runtimeType}');

    return QuestionModel(
      id: json['id'],
      content: json['content'] ?? '',
      type: json['type'] ?? '',
      level: json['level'] ?? '',
      duration: json['duration'] ?? '',
      teacherId: json['teacherId'],
      answers: (json['answers'] as List<dynamic>?)
              ?.map((e) => AnswerModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'type': type,
      'level': level,
      'duration': duration,
      'teacherId': teacherId,
      'answers': answers.map((answer) => answer.toJson()).toList(),
    };
  }
}
