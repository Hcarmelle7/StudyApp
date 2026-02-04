// screens/user_list_screen.dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mystudy/router/app_router.gr.dart';
import 'package:mystudy/features/subject/presentation/widgets/subject_widget.dart';

import '../../../../../auth/business_logic/profile_bloc/profile_bloc.dart';
import '../../../../../../core/services/network/service_locator.dart';
import '../../../../../subject/business_logic/subject_bloc/subject_bloc.dart';

@RoutePage()
class QuestionListPage extends StatelessWidget {
  const QuestionListPage({super.key}); // Passer AuthService dans le constructeur

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Question List')),
      body: const SingleChildScrollView(child: SubjectWidget(image: AssetImage('assets/images/book.png'))),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context).push(
          //     MaterialPageRoute(builder: (context) => UpdateStudentPage()));
          context.router.push(CreateQuestionRoute());
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(items:  [
        BottomNavigationBarItem(icon: InkWell(onTap: () {
          getIt.get<ProfileBloc>().add(GetCurrentUserEvent());

          context.router.pushAndPopUntil(const TeacherBoardRoute(), predicate: (router) => false);
        },child: const Icon(Icons.home)), label: 'home'),
        BottomNavigationBarItem(icon: InkWell(onTap: (){
          context.router.push(CreateQuestionRoute());
        } ,child: const Icon(Icons.question_answer)), label: 'Questions'),
        BottomNavigationBarItem(icon: InkWell(onTap: () {
          getIt.get<SubjectBloc>().add(GetAllSubjectEvent());
          context.router.pushAndPopUntil(const QuestionListRoute(), predicate: (router) => false);
        },child: const Icon(Icons.folder_open)), label: 'Library'),
      ]),
    );
  }
}
