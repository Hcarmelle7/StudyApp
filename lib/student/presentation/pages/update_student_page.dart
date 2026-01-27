// lib/screens/register_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mystudy/auth/business_logic/profile_bloc/profile_bloc.dart';
import 'package:mystudy/level/business_logic/bloc/level_bloc.dart';
import 'package:mystudy/level/presentation/widgets/level_widget.dart';
import 'package:mystudy/quiz/business_logic/score_bloc/score_bloc.dart';
import 'package:mystudy/router/app_router.gr.dart';
import 'package:mystudy/state/service_locator.dart';
import 'package:mystudy/student/business_logic/bloc/student_bloc.dart';
import 'package:mystudy/student/data/model/student_model.dart';
import 'package:mystudy/subject/business_logic/subject_bloc/subject_bloc.dart';
import 'package:mystudy/tools/themes/colors/app_colors.dart';

// ignore: must_be_immutable
@RoutePage()
class UpdateStudentPage extends StatefulWidget {
  const UpdateStudentPage({super.key});

  @override
  State<UpdateStudentPage> createState() => _UpdateStudentPageState();
}

class _UpdateStudentPageState extends State<UpdateStudentPage> {
  final PageController _pageController = PageController();
  int selectedLevel = 0;

  int _currentPage = 0;

  void _submit(BuildContext context) {
    // Implement registration logic here
    final student = StudentModel(levelId: selectedLevel);

    BlocProvider.of<StudentBloc>(context).add(UpdateStudentEvent(student));
  }

  void _nextPage() {
    if (_currentPage < 2) {
      setState(() {
        _currentPage++;
      });
      _pageController.nextPage(
          duration: const Duration(seconds: 01), curve: Curves.ease);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
      _pageController.previousPage(
          duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Account'),
        leading: _currentPage > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _previousPage,
              )
            : null,
      ),
      body: BlocListener<StudentBloc, StudentState>(
        listener: (context, state) {
          if (state is UpdateStudentLoading) {
            context.loaderOverlay.show();
          }
          if (state is UpdateStudentSuccess) {
            context.loaderOverlay.hide();
            getIt.get<ProfileBloc>().add(GetCurrentUserEvent());
              getIt.get<SubjectBloc>().add(GetAllSubjectEvent());
              getIt.get<ScoreBloc>().add(GetAllScoresEvent());

              context.router.pushAndPopUntil(const AppRoute(),
                  predicate: (router) => false);
          } else if (state is UpdateStudentFailure) {
            context.loaderOverlay.hide();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erreur : ${state.error}')),
            );
          }
        },
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: BlocBuilder<LevelBloc, LevelState>(
                builder: (context, state) {
                  if (state is GetAllLevelsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is GetAllLevelsFailure) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else if (state is GetAllLevelsSuccess) {
                    return Column(
                      children: [
                        const Text(
                          'which Grade are you in  \n (2024-2025)',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w900),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Expanded(
                          child: GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 6,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1
                            ),
                            itemCount: state.level.length,
                            itemBuilder: (context, index) {
                              final level = state.level[index];
                              return InkWell(
                                  onTap: () {
                                    selectedLevel = level.id;
                                    // context.router.push(UpdateStudentRoute());
                                    _nextPage();
                                    print(selectedLevel);
                                  },
                                  child: LevelWidget(title: level.title));
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                },      
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome to Learnify',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Your account has been created succesfully. Satrt  exploring and make the most of your learning journey',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 25),
                  BlocBuilder<StudentBloc, StudentState>(
                    builder: (context, state) {
                      return Center(
                        child: ElevatedButton(
                          onPressed: state is UpdateStudentLoading
                              ? null
                              : () => _submit(context),
                          child: state is UpdateStudentLoading
                              ? const CircularProgressIndicator() // Affichez le CircularProgressIndicator
                              : const Text(
                                  'Terminer',
                                  style: TextStyle(color: AppColors.white),
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
