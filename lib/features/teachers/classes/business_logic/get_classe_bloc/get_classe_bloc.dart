import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mystudy/features/teachers/classes/data/models/classe_model.dart';
import 'package:mystudy/features/teachers/classes/data/repositories/class_repository.dart';

part 'get_classe_event.dart';
part 'get_classe_state.dart';

class GetClasseBloc extends Bloc<GetClasseEvent, GetClasseState> {
  final ClassRepository repository;
  GetClasseBloc({required this.repository}) : super(GetClasseInitial()) {
    on<GetClasseByIdEvent>((event, emit) async {
      try {
        emit(GetClasseByIdLoading());
        final classe = await repository.getClasse(event.id);
        emit(GetClasseByIdSuccess(classe));
      } catch (e) {
        emit(GetClasseByIdFailure(e.toString()));
      }
    });
  }
}
