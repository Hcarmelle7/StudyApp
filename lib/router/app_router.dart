import 'package:auto_route/auto_route.dart';
import 'package:mystudy/router/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: OnboardingRoute.page),
        AutoRoute(page: AppInitRoute.page, initial: true),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: UserListRoute.page),
        AutoRoute(page: UpdateStudentRoute.page),
        AutoRoute(page: LevelRoute.page),
        AutoRoute(page: CreateLevelRoute.page),
        AutoRoute(page: QuestionListRoute.page),
        AutoRoute(page: CreateQuestionRoute.page),
        AutoRoute(page: CreateQuestionForm.page),
        AutoRoute(page: CreateAnswerWidget.page),
        AutoRoute(page: LegisterRoute.page),
        AutoRoute(page: TeacherBoardRoute.page),
        AutoRoute(page: SeachDataRoute.page),
        AutoRoute(page: SubjectListRoute.page),

        //AutoRoute(page: GameRoute.page),
        AutoRoute(page: AppRoute.page, children: [
          AutoRoute(page: StudentBoardRoute.page, initial: true),
          AutoRoute(page: GameRoute.page),
          AutoRoute(page: QuizRoute.page),
          AutoRoute(page: CreateQuizRoute.page),
          AutoRoute(page: SubjectListRoute.page),
        ]),
        AutoRoute(page: QuizGameRoute.page)
      ];
}
