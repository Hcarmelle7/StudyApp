
class AnswerModel {
  late final int? questionId;
  final String content;
  final bool isTrue;

  AnswerModel(
      { this.questionId, required this.content, required this.isTrue});

  // Méthode pour convertir le JSON en objet Dart
  factory AnswerModel.fromJson(Map<String, dynamic> json) {

    return AnswerModel(
      content: json['content'],
      isTrue: json['isTrue'] is bool ? json['isTrue'] : json['isTrue'] == 1,
      questionId: json['teacherId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'questionId': questionId,
      'isTrue': isTrue
    };
  }
}
