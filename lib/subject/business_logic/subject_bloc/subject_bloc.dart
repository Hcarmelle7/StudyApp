import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mystudy/subject/data/models/subject_model.dart';
import 'package:mystudy/subject/data/repositories/subject_repository.dart';

part 'subject_event.dart';
part 'subject_state.dart';

class SubjectBloc extends Bloc<SubjectEvent, SubjectState> {
  final SubjectRepository repository;
  SubjectBloc({required this.repository}) : super(SubjectInitial()) {
    on<GetAllSubjectEvent>((event, emit) async {
      emit(GetAllSubjectsLoading());
      try {
        final subject = await repository.getAllSubject();
        emit(GetAllSubjectsSuccess(subject));
      } catch (e) {
        emit(GetAllSubjectsFailure(message: e.toString()));
      }
    });
  }
}
