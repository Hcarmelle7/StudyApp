class StudentModel {
  int? id;
  int? userId;
  int? levelId;
  // DateTime createdAt;
  // DateTime updatedAt;

  StudentModel({
    this.id,
    this.userId,
    this.levelId,
    // required this.createdAt,
    // required this.updatedAt,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['id'],
      userId: json['userId'],
      levelId: json['levelId'],
      // createdAt: json['createdAt'],
      // updatedAt: json['updatedAt'],
    );
  }
  // Convertir un objet Dart en JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'levelId': levelId,
      // 'createdAt': createdAt.toIso8601String(),
      // 'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
