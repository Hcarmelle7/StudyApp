import 'package:mystudy/subject/data/models/subject_model.dart';
import 'package:mystudy/subject/data/services/subject_service.dart';

class SubjectRepository {
  final SubjectService service;

  SubjectRepository({required this.service});

  Future<List<SubjectModel>> getAllSubject() async {
    return await service.getAllSubjects();
  }

  Future<SubjectModel> createSubject(SubjectModel sub) async {
    return await service.createSubject(sub);
  } 

  Future<void> updateSubject(int id, SubjectModel sub) async {
    return await service.updateSubject(id, sub);
  }

  Future<void> deleteSubject(int id) async {
    return await service.deleteSubject(id);
  }
}
