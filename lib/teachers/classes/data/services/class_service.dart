import 'package:dio/dio.dart';
import 'package:mystudy/teachers/classes/data/models/classe_model.dart';

class ClassService {
  final Dio http;

  ClassService({required this.http});
  
  Future<ClasseModel> createClasse(ClasseModel classe) async {
    final response = await http.post('/add/Classe', data: classe.toJson());
    return ClasseModel.fromJson(response.data);
  }

  Future<List<ClasseModel>> getAllClasses() async {
    final response = await http.get('/classes');
    final List<dynamic> data = response.data;
    print(data);
    return data.map((classe) => ClasseModel.fromJson(classe)).toList();
  }

  Future<ClasseModel> getClasse(int id) async {
    final response = await http.get('/classe/$id');
    return ClasseModel.fromJson(response.data);
  }

Future<void> updateClasse(int id, ClasseModel classe) async {
    final response = await http.put('/classe/$id', data: classe.toJson());
    return response.data;
  }

  Future<void> deleteClasse(int id) async {
    final response = await http.delete('/classe/$id');
    return response.data;
  }
}
