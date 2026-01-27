import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mystudy/auth/business_logic/profile_bloc/profile_bloc.dart';
import 'package:mystudy/level/business_logic/bloc/level_bloc.dart';
import 'package:mystudy/level/data/repositories/level_repository.dart';
import 'package:mystudy/level/data/services/level_service.dart';
import 'package:mystudy/quiz/answers/business_logic/create_answer_bloc/create_answer_bloc.dart';
import 'package:mystudy/quiz/answers/business_logic/get_answer_bloc/get_answer_bloc.dart';
import 'package:mystudy/quiz/business_logic/create_quiz_bloc/create_quiz_bloc.dart';
import 'package:mystudy/quiz/business_logic/quiz_bloc/quiz_bloc.dart';
import 'package:mystudy/quiz/business_logic/quiz_by_id_bloc/quiz_by_id_bloc.dart';
import 'package:mystudy/quiz/business_logic/score_bloc/score_bloc.dart';
import 'package:mystudy/quiz/data/repositories/quiz_repository.dart';
import 'package:mystudy/quiz/data/repositories/score_repository.dart';
import 'package:mystudy/quiz/data/services/quiz_service.dart';
import 'package:mystudy/quiz/data/services/score_service.dart';
import 'package:mystudy/quiz/questions/business_logic/create_question_bloc/create_question_bloc.dart';
import 'package:mystudy/quiz/questions/business_logic/questions_bloc/questions_bloc.dart';
import 'package:mystudy/quiz/answers/data/repositories/answer_repository.dart';
import 'package:mystudy/quiz/questions/data/repositories/question_repository.dart';
import 'package:mystudy/quiz/answers/data/services/Answer_service.dart';
import 'package:mystudy/quiz/questions/data/services/question_service.dart';
import 'package:mystudy/state/token_interceptor.dart';
import 'package:mystudy/auth/business_logic/bloc/auth_bloc.dart';
import 'package:mystudy/auth/data/repositories/auth_repository.dart';
import 'package:mystudy/auth/data/service/auth_service.dart';
import 'package:mystudy/student/business_logic/bloc/student_bloc.dart';
import 'package:mystudy/student/data/repositories/student_repository.dart';
import 'package:mystudy/student/data/services/student_service.dart';
import 'package:mystudy/subject/business_logic/subject_bloc/subject_bloc.dart';
import 'package:mystudy/subject/data/repositories/subject_repository.dart';
import 'package:mystudy/subject/data/services/subject_service.dart';

final getIt = GetIt.instance;
String baseUrl = "http://localhost:3000/api";

void setupLocator() {
  getIt.registerSingleton<Dio>(Dio(
    BaseOptions(
        baseUrl: baseUrl,

        // connectTimeout: Duration(seconds: 5),
        headers: {"Content-Type": "application/json; charset=utf-8"}),
  )..interceptors.add(TokenInterceptor()));

  // authentication
  getIt.registerSingleton(AuthService(http: getIt.get<Dio>()));
  getIt.registerSingleton(AuthRepository(service: getIt.get<AuthService>()));
  getIt.registerSingleton(AuthBloc(repository: getIt.get<AuthRepository>()));
  getIt.registerSingleton(ProfileBloc(repository: getIt.get<AuthRepository>()));

  // students
  getIt.registerSingleton(StudentService(http: getIt.get<Dio>()));
  getIt.registerSingleton(
      StudentRepository(service: getIt.get<StudentService>()));
  getIt.registerSingleton(
      StudentBloc(repository: getIt.get<StudentRepository>()));

  // levels
  getIt.registerSingleton(LevelService(http: getIt.get<Dio>()));
  getIt.registerSingleton(LevelRepository(service: getIt.get<LevelService>()));
  getIt.registerSingleton(LevelBloc(repository: getIt.get<LevelRepository>()));

// subjcts
  getIt.registerSingleton(SubjectService(http: getIt.get<Dio>()));
  getIt.registerSingleton(
      SubjectRepository(service: getIt.get<SubjectService>()));
  getIt.registerSingleton(
      SubjectBloc(repository: getIt.get<SubjectRepository>()));

  // get answers
  getIt.registerSingleton(AnswerService(http: getIt.get<Dio>()));
  getIt
      .registerSingleton(AnswerRepository(service: getIt.get<AnswerService>()));
  getIt.registerSingleton(
      GetAnswerBloc(repository: getIt.get<AnswerRepository>()));

  // create answers
  getIt.registerSingleton(
      CreateAnswerBloc(repository: getIt.get<AnswerRepository>()));

  // get questions
  getIt.registerSingleton(QuestionService(http: getIt.get<Dio>()));
  getIt.registerSingleton(QuestionRepository(
      service: getIt.get<QuestionService>(),
      answerService: getIt.get<AnswerService>()));
  getIt.registerSingleton(
      QuestionsBloc(repository: getIt.get<QuestionRepository>()));

// create questions
  getIt.registerSingleton(
      CreateQuestionBloc(repository: getIt.get<QuestionRepository>()));

  // get quiz
  getIt.registerSingleton(QuizService(http: getIt.get<Dio>()));
  getIt.registerSingleton(QuizRepository(
      service: getIt.get<QuizService>(),
      questionService: getIt.get<QuestionService>()));

  //cretae quiz
  getIt.registerSingleton(ScoreService(http: getIt.get<Dio>()));
  getIt.registerSingleton(ScoreRepository(service: getIt.get<ScoreService>()));
  getIt.registerSingleton(QuizBloc(repository: getIt.get<QuizRepository>()));
  getIt
      .registerSingleton(QuizByIdBloc(repository: getIt.get<QuizRepository>()));
  getIt.registerSingleton(CreateQuizBloc(
      repository: getIt.get<QuizRepository>(),
      scoreRepository: getIt.get<ScoreRepository>()));

  //score
  //getIt.registerSingleton(ScoreService(http: getIt.get<Dio>()));
  //getIt.registerSingleton(ScoreRepository(service: getIt.get<ScoreService>()));
  getIt.registerSingleton(ScoreBloc(repository: getIt.get<ScoreRepository>()));
}
