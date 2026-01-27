class SubjectModel {
  final int id;
  final String title;
  final String description;

  SubjectModel(
      {required this.id, required this.title, required this.description});

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
        id: json['id'], title: json['title'], description: json['description']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }
}
