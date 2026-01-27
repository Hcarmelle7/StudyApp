class ClasseModel {
  final int? id;
  final String title;
  final int levelId;
  final int Nstudents;

  ClasseModel(
      {this.id,
      required this.title,
      required this.levelId,
      required this.Nstudents});

  factory ClasseModel.fromJson(Map<String, dynamic> json) {
    return ClasseModel(
        id: json['id'],
        title: json['title'],
        levelId: json['levelId'],
        Nstudents: json['Nstudents']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'levelId': levelId,
      'Nstudents': Nstudents,
    };
  }
}
