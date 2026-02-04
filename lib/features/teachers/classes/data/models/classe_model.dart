class ClasseModel {
  final int? id;
  final String title;
  final int levelId;
  final int nStudents;

  ClasseModel(
      {this.id,
      required this.title,
      required this.levelId,
      required this.nStudents});

  factory ClasseModel.fromJson(Map<String, dynamic> json) {
    return ClasseModel(
        id: json['id'],
        title: json['title'],
        levelId: json['levelId'],
        nStudents: json['Nstudents']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'levelId': levelId,
      'Nstudents': nStudents,
    };
  }
}
