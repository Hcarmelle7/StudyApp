import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mystudy/auth/business_logic/bloc/auth_bloc.dart';
import 'package:mystudy/auth/business_logic/profile_bloc/profile_bloc.dart';
import 'package:mystudy/router/app_router.gr.dart';
import 'package:mystudy/state/service_locator.dart';
import 'package:mystudy/subject/business_logic/subject_bloc/subject_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../quiz/business_logic/score_bloc/score_bloc.dart';

@RoutePage()
class AppInitScreen extends StatefulWidget {
  const AppInitScreen({super.key});

  @override
  State<AppInitScreen> createState() => _AppInitScreenState();
}

class _AppInitScreenState extends State<AppInitScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  void init() async {
    _controller = AnimationController(vsync: this);
    context.read<AuthBloc>().add(CheckAuthStateEvent());
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        List<String> user_role =
            prefs.getStringList('role') ?? ['ROLE_STUDENT'];

        print(user_role.first);

        _controller.addStatusListener((status) {
          if (state is FirstTimeLaunch && status == AnimationStatus.completed) {
            context.router.pushAndPopUntil(const OnboardingRoute(),
                predicate: (route) => false);
          } else if (state is CheckAuthStateSuccess &&
              status == AnimationStatus.completed) {
            if (user_role.first == 'ROLE_STUDENT') {
              getIt.get<ProfileBloc>().add(GetCurrentUserEvent());
              getIt.get<SubjectBloc>().add(GetAllSubjectEvent());
              getIt.get<ScoreBloc>().add(GetAllScoresEvent());

              context.router.pushAndPopUntil(const AppRoute(),
                  predicate: (router) => false);
            } else if (user_role.first == 'ROLE_TEACHER') {
              getIt.get<ProfileBloc>().add(GetCurrentUserEvent());
              context.router.pushAndPopUntil(const TeacherBoardRoute(),
                  predicate: (router) => false);
            } else {
              context.router.pushAndPopUntil(const HomeRoute(),
                  predicate: (router) => false);
            }
          } else if (state is CheckAuthStateFailure &&
              status == AnimationStatus.completed) {
            context.router
                .pushAndPopUntil(LoginRoute(), predicate: (router) => false);
          }
        });
      },
      child: Scaffold(
        body: Center(
            child: Lottie.asset(
          'assets/animations/study.json',
          height: 200,
          width: 200,
          controller: _controller,
          onLoaded: (composition) {
            // Configure the AnimationController with the duration of the
            // Lottie file and start the animation.
            _controller.duration = composition.duration;
            _controller.forward();
          },
        )),
      ),
    );
  }
}
