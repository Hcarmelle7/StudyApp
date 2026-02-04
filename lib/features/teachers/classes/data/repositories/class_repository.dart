import 'package:mystudy/features/teachers/classes/data/models/classe_model.dart';
import 'package:mystudy/features/teachers/classes/data/services/class_service.dart';

class ClassRepository {
  final ClassService service;

  ClassRepository({required this.service});

  Future<List<ClasseModel>> getAllClasses() async {
    return await service.getAllClasses();
  }

  Future<ClasseModel> getClasse(int id) async {
    return await service.getClasse(id);
  }

  Future<ClasseModel> createClasse(ClasseModel classe) async {
    return await service.createClasse(classe);
  } 

  Future<void> updateClasse(int id, ClasseModel classe) async {
    return await service.updateClasse(id, classe);
  }

  Future<void> deleteClasse(int id) async {
    return await service.deleteClasse(id);
  }
}
