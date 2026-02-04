import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mystudy/features/teachers/classes/data/models/classe_model.dart';

part 'get_classes_event.dart';
part 'get_classes_state.dart';

class GetClassesBloc extends Bloc<GetClassesEvent, GetClassesState> {
  GetClassesBloc() : super(GetClassesInitial()) {
    on<GetClassesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
