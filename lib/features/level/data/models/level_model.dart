
class LevelModel {
  final int id;
  final String title;

  LevelModel({
    required this.id,
    required this.title,
  });

  // Méthode pour convertir un objet JSON en instance de LevelModel
  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      id: json['id'],
      title: json['title'],
    );
  }

  // Méthode pour convertir une instance de LevelModel en objet JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
    };
  }
}
