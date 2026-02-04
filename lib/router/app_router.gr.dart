// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i24;
import 'package:flutter/material.dart' as _i25;
import 'package:mystudy/app_screen.dart' as _i2;
import 'package:mystudy/features/auth/presentation/login_screen.dart' as _i12;
import 'package:mystudy/features/auth/presentation/profile_screen.dart' as _i14;
import 'package:mystudy/features/auth/presentation/register.dart' as _i10;
import 'package:mystudy/features/auth/presentation/user_list_screen.dart' as _i23;
import 'package:mystudy/home_screen.dart' as _i9;
import 'package:mystudy/features/level/presentation/pages/create_level_page.dart' as _i4;
import 'package:mystudy/features/level/presentation/pages/level_page.dart' as _i11;
import 'package:mystudy/features/onboarding/onboarding_screen.dart' as _i13;
import 'package:mystudy/features/quiz/presentation/pages/create.dart' as _i7;
import 'package:mystudy/features/quiz/presentation/pages/quiz_game/game_screen.dart'
    as _i8;
import 'package:mystudy/features/quiz/presentation/pages/quiz_game/quiz_game_screen.dart'
    as _i16;
import 'package:mystudy/features/quiz/presentation/pages/quiz_screen.dart' as _i17;
import 'package:mystudy/features/quiz/component/questions/presentation/pages/create_question_page.dart'
    as _i6;
import 'package:mystudy/features/quiz/component/questions/presentation/pages/question_list_page.dart'
    as _i15;
import 'package:mystudy/features/quiz/component/questions/presentation/pages/test.dart' as _i5;
import 'package:mystudy/features/quiz/component/questions/presentation/widgets/create_answer_widget.dart'
    as _i3;
import 'package:mystudy/features/search/pages/seach_data_page.dart' as _i18;
import 'package:mystudy/core/services/presentation/app_init_screen.dart' as _i1;
import 'package:mystudy/features/student/presentation/pages/update_student_page.dart'
    as _i22;
import 'package:mystudy/features/students/student_board.dart' as _i19;
import 'package:mystudy/features/subject/presentation/pages/subject_list_screen.dart'
    as _i20;
import 'package:mystudy/features/teachers/teacher_board.dart' as _i21;

/// generated route for
/// [_i1.AppInitScreen]
class AppInitRoute extends _i24.PageRouteInfo<void> {
  const AppInitRoute({List<_i24.PageRouteInfo>? children})
      : super(
          AppInitRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppInitRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i1.AppInitScreen();
    },
  );
}

/// generated route for
/// [_i2.AppScreen]
class AppRoute extends _i24.PageRouteInfo<void> {
  const AppRoute({List<_i24.PageRouteInfo>? children})
      : super(
          AppRoute.name,
          initialChildren: children,
        );

  static const String name = 'AppRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i2.AppScreen();
    },
  );
}

/// generated route for
/// [_i3.CreateAnswerWidget]
class CreateAnswerWidget extends _i24.PageRouteInfo<CreateAnswerWidgetArgs> {
  CreateAnswerWidget({
    _i25.Key? key,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          CreateAnswerWidget.name,
          args: CreateAnswerWidgetArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'CreateAnswerWidget';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateAnswerWidgetArgs>(
          orElse: () => const CreateAnswerWidgetArgs());
      return _i3.CreateAnswerWidget(key: args.key);
    },
  );
}

class CreateAnswerWidgetArgs {
  const CreateAnswerWidgetArgs({this.key});

  final _i25.Key? key;

  @override
  String toString() {
    return 'CreateAnswerWidgetArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.CreateLevelPage]
class CreateLevelRoute extends _i24.PageRouteInfo<CreateLevelRouteArgs> {
  CreateLevelRoute({
    _i25.Key? key,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          CreateLevelRoute.name,
          args: CreateLevelRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'CreateLevelRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateLevelRouteArgs>(
          orElse: () => const CreateLevelRouteArgs());
      return _i4.CreateLevelPage(key: args.key);
    },
  );
}

class CreateLevelRouteArgs {
  const CreateLevelRouteArgs({this.key});

  final _i25.Key? key;

  @override
  String toString() {
    return 'CreateLevelRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i5.CreateQuestionForm]
class CreateQuestionForm extends _i24.PageRouteInfo<void> {
  const CreateQuestionForm({List<_i24.PageRouteInfo>? children})
      : super(
          CreateQuestionForm.name,
          initialChildren: children,
        );

  static const String name = 'CreateQuestionForm';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i5.CreateQuestionForm();
    },
  );
}

/// generated route for
/// [_i6.CreateQuestionPage]
class CreateQuestionRoute extends _i24.PageRouteInfo<CreateQuestionRouteArgs> {
  CreateQuestionRoute({
    _i25.Key? key,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          CreateQuestionRoute.name,
          args: CreateQuestionRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'CreateQuestionRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CreateQuestionRouteArgs>(
          orElse: () => const CreateQuestionRouteArgs());
      return _i6.CreateQuestionPage(key: args.key);
    },
  );
}

class CreateQuestionRouteArgs {
  const CreateQuestionRouteArgs({this.key});

  final _i25.Key? key;

  @override
  String toString() {
    return 'CreateQuestionRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i7.CreateQuizScreen]
class CreateQuizRoute extends _i24.PageRouteInfo<void> {
  const CreateQuizRoute({List<_i24.PageRouteInfo>? children})
      : super(
          CreateQuizRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateQuizRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i7.CreateQuizScreen();
    },
  );
}

/// generated route for
/// [_i8.GameScreen]
class GameRoute extends _i24.PageRouteInfo<void> {
  const GameRoute({List<_i24.PageRouteInfo>? children})
      : super(
          GameRoute.name,
          initialChildren: children,
        );

  static const String name = 'GameRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i8.GameScreen();
    },
  );
}

/// generated route for
/// [_i9.HomeScreen]
class HomeRoute extends _i24.PageRouteInfo<void> {
  const HomeRoute({List<_i24.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i9.HomeScreen();
    },
  );
}

/// generated route for
/// [_i10.LegisterPage]
class LegisterRoute extends _i24.PageRouteInfo<void> {
  const LegisterRoute({List<_i24.PageRouteInfo>? children})
      : super(
          LegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'LegisterRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i10.LegisterPage();
    },
  );
}

/// generated route for
/// [_i11.LevelPage]
class LevelRoute extends _i24.PageRouteInfo<void> {
  const LevelRoute({List<_i24.PageRouteInfo>? children})
      : super(
          LevelRoute.name,
          initialChildren: children,
        );

  static const String name = 'LevelRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i11.LevelPage();
    },
  );
}

/// generated route for
/// [_i12.LoginScreen]
class LoginRoute extends _i24.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i25.Key? key,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<LoginRouteArgs>(orElse: () => const LoginRouteArgs());
      return _i12.LoginScreen(key: args.key);
    },
  );
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i25.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.OnboardingScreen]
class OnboardingRoute extends _i24.PageRouteInfo<void> {
  const OnboardingRoute({List<_i24.PageRouteInfo>? children})
      : super(
          OnboardingRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i13.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i14.ProfileScreen]
class ProfileRoute extends _i24.PageRouteInfo<void> {
  const ProfileRoute({List<_i24.PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i14.ProfileScreen();
    },
  );
}

/// generated route for
/// [_i15.QuestionListPage]
class QuestionListRoute extends _i24.PageRouteInfo<void> {
  const QuestionListRoute({List<_i24.PageRouteInfo>? children})
      : super(
          QuestionListRoute.name,
          initialChildren: children,
        );

  static const String name = 'QuestionListRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i15.QuestionListPage();
    },
  );
}

/// generated route for
/// [_i16.QuizGameScreen]
class QuizGameRoute extends _i24.PageRouteInfo<void> {
  const QuizGameRoute({List<_i24.PageRouteInfo>? children})
      : super(
          QuizGameRoute.name,
          initialChildren: children,
        );

  static const String name = 'QuizGameRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i16.QuizGameScreen();
    },
  );
}

/// generated route for
/// [_i17.QuizScreen]
class QuizRoute extends _i24.PageRouteInfo<QuizRouteArgs> {
  QuizRoute({
    _i25.Key? key,
    List<_i24.PageRouteInfo>? children,
  }) : super(
          QuizRoute.name,
          args: QuizRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'QuizRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<QuizRouteArgs>(orElse: () => const QuizRouteArgs());
      return _i17.QuizScreen(key: args.key);
    },
  );
}

class QuizRouteArgs {
  const QuizRouteArgs({this.key});

  final _i25.Key? key;

  @override
  String toString() {
    return 'QuizRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i18.SeachDataPage]
class SeachDataRoute extends _i24.PageRouteInfo<void> {
  const SeachDataRoute({List<_i24.PageRouteInfo>? children})
      : super(
          SeachDataRoute.name,
          initialChildren: children,
        );

  static const String name = 'SeachDataRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i18.SeachDataPage();
    },
  );
}

/// generated route for
/// [_i19.StudentBoardScreen]
class StudentBoardRoute extends _i24.PageRouteInfo<void> {
  const StudentBoardRoute({List<_i24.PageRouteInfo>? children})
      : super(
          StudentBoardRoute.name,
          initialChildren: children,
        );

  static const String name = 'StudentBoardRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i19.StudentBoardScreen();
    },
  );
}

/// generated route for
/// [_i20.SubjectListScreen]
class SubjectListRoute extends _i24.PageRouteInfo<void> {
  const SubjectListRoute({List<_i24.PageRouteInfo>? children})
      : super(
          SubjectListRoute.name,
          initialChildren: children,
        );

  static const String name = 'SubjectListRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i20.SubjectListScreen();
    },
  );
}

/// generated route for
/// [_i21.TeacherBoardScreen]
class TeacherBoardRoute extends _i24.PageRouteInfo<void> {
  const TeacherBoardRoute({List<_i24.PageRouteInfo>? children})
      : super(
          TeacherBoardRoute.name,
          initialChildren: children,
        );

  static const String name = 'TeacherBoardRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i21.TeacherBoardScreen();
    },
  );
}

/// generated route for
/// [_i22.UpdateStudentPage]
class UpdateStudentRoute extends _i24.PageRouteInfo<void> {
  const UpdateStudentRoute({List<_i24.PageRouteInfo>? children})
      : super(
          UpdateStudentRoute.name,
          initialChildren: children,
        );

  static const String name = 'UpdateStudentRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i22.UpdateStudentPage();
    },
  );
}

/// generated route for
/// [_i23.UserListScreen]
class UserListRoute extends _i24.PageRouteInfo<void> {
  const UserListRoute({List<_i24.PageRouteInfo>? children})
      : super(
          UserListRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserListRoute';

  static _i24.PageInfo page = _i24.PageInfo(
    name,
    builder: (data) {
      return const _i23.UserListScreen();
    },
  );
}
