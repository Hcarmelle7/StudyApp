class ScoreModel {
  final int id;
  final double score;
  final int? quizId;
  final int? userId;
  ScoreModel({
    required this.id,
    required this.score,
    this.quizId,
    this.userId,
  });

  // Deserialize JSON to Dart object
  factory ScoreModel.fromJson(Map<String, dynamic> json) {
    return ScoreModel(
        id: json['id'],
        score: json['score'].toDouble(),
        quizId: json['quizId'],
        userId: json['userId']);
  }

  // Serialize Dart object to JSON
  Map<String, dynamic> toJson() {
    return {'id': id, 'score': score, 'quizid': quizId, 'userId': userId};
  }
}
