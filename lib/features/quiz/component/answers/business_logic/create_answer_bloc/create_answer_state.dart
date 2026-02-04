part of 'create_answer_bloc.dart';

@immutable
sealed class CreateAnswerState {}

final class CreateAnswerInitial extends CreateAnswerState {}


final class CreateAnswerLoading extends CreateAnswerState {}

final class CreateAnswerSuccess extends CreateAnswerState {
  final AnswerModel answer;
  CreateAnswerSuccess(this.answer);
}   

final class CreateAnswerFailure extends CreateAnswerState {
  final String message;
  CreateAnswerFailure(this.message);
} 

final class UpdateAnswerLoading extends CreateAnswerState {}  

final class UpdateAnswerSuccess extends CreateAnswerState {
  final AnswerModel answer;
  UpdateAnswerSuccess(this.answer);
} 

final class UpdateAnswerFailure extends CreateAnswerState {
  final String message;
  UpdateAnswerFailure(this.message);
} 

final class DeleteAnswerLoading extends CreateAnswerState {}

final class DeleteAnswerSuccess extends CreateAnswerState {}

final class DeleteAnswerFailure extends CreateAnswerState {
  final String message;
  DeleteAnswerFailure(this.message);
}