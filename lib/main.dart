import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
// Assurez-vous que vos imports sont corrects ici
import 'package:mystudy/auth/business_logic/profile_bloc/profile_bloc.dart';
import 'package:mystudy/level/business_logic/bloc/level_bloc.dart';
import 'package:mystudy/quiz/answers/business_logic/create_answer_bloc/create_answer_bloc.dart';
import 'package:mystudy/quiz/answers/business_logic/get_answer_bloc/get_answer_bloc.dart';
import 'package:mystudy/quiz/business_logic/create_quiz_bloc/create_quiz_bloc.dart';
import 'package:mystudy/quiz/business_logic/quiz_bloc/quiz_bloc.dart';
import 'package:mystudy/quiz/business_logic/quiz_by_id_bloc/quiz_by_id_bloc.dart';
import 'package:mystudy/quiz/business_logic/score_bloc/score_bloc.dart';
import 'package:mystudy/quiz/questions/business_logic/create_question_bloc/create_question_bloc.dart';
import 'package:mystudy/quiz/questions/business_logic/questions_bloc/questions_bloc.dart';
import 'package:mystudy/router/app_router.dart';
import 'package:mystudy/state/business_logic/theme_cubit.dart';
import 'package:mystudy/state/service_locator.dart';
import 'package:mystudy/auth/business_logic/bloc/auth_bloc.dart';
import 'package:mystudy/student/business_logic/bloc/student_bloc.dart';
import 'package:mystudy/subject/business_logic/subject_bloc/subject_bloc.dart';
import 'package:mystudy/tools/themes/light_theme.dart';

void main() async {
  // MODIFICATION 1 : Indispensable pour éviter l'écran blanc au démarrage
  WidgetsFlutterBinding.ensureInitialized();

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('fonts/alegrey/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  
  setupLocator(); // Assurez-vous que cette fonction ne contient pas de "await" critique
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _approuter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ThemeCubit>(
              create: (context) => ThemeCubit(),
            ),
            BlocProvider(create: (context) => getIt.get<AuthBloc>()),
            BlocProvider(create: (context) => getIt.get<ProfileBloc>()),
            BlocProvider(create: (context) => getIt.get<StudentBloc>()),
            BlocProvider(create: (context) => getIt.get<LevelBloc>()),
            BlocProvider(create: (context) => getIt.get<SubjectBloc>()),
            BlocProvider(create: (context) => getIt.get<CreateQuestionBloc>()),
            BlocProvider(
              create: (context) => getIt.get<QuestionsBloc>(),
            ),
            BlocProvider(create: (context) => getIt.get<GetAnswerBloc>()),
            BlocProvider(create: (context) => getIt.get<CreateAnswerBloc>()),
            BlocProvider(create: (context) => getIt.get<CreateQuizBloc>()),
            BlocProvider(create: (context) => getIt.get<QuizBloc>()),
            BlocProvider(create: (context) => getIt.get<QuizByIdBloc>()),
            BlocProvider(create: (context) => getIt.get<ScoreBloc>()),
          ],
          // MODIFICATION 2 : Ajout d'un Builder pour obtenir le bon contexte
          child: Builder(
            builder: (innerContext) {
              return MaterialApp.router(
                debugShowCheckedModeBanner: false,
                routerConfig: _approuter.config(),
                title: 'My Study',
                // On utilise innerContext ici, qui connait maintenant les Providers
                themeMode: innerContext.select((ThemeCubit themeCubit) => themeCubit.state.themeMode),
                // Assurez-vous d'avoir un lightTheme défini, sinon ça peut planter si le mode est light
                theme: lightTheme(), // J'ai supposé que vous avez lightTheme() vu les imports
                darkTheme: lightTheme(),
              );
            },
          ),
        ),
      ),
    );
  }
}