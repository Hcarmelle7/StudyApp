import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mystudy/teachers/classes/data/models/classe_model.dart';
import 'package:mystudy/teachers/classes/data/repositories/class_repository.dart';

part 'create_classes_event.dart';
part 'create_classes_state.dart';

class CreateClassesBloc extends Bloc<CreateClassesEvent, CreateClassesState> {
  final ClassRepository repository;
  CreateClassesBloc({required this.repository}) : super(CreateClassesInitial()) {
    on<CreateClasseEvent>((event, emit) async {
      emit(CreateClasseLoading());
      try {
        final Classe = await repository.createClasse(event.Classe);
        emit(CreateClasseSuccess(Classe));
      } catch (e) {
        emit(CreateClasseFailure(message: e.toString()));
      }
    });
  }
}
