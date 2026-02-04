// screens/user_list_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystudy/features/student/business_logic/bloc/student_bloc.dart';
import 'package:mystudy/features/student/presentation/pages/update_student_page.dart';

class StudentListPage extends StatelessWidget {
  const StudentListPage({super.key}); // Passer AuthService dans le constructeur

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student List')),
      body: BlocBuilder<StudentBloc, StudentState>(
        builder: (context, state) {
          if (state is FetchStudentsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchStudentsFailure) {
            return Center(child: Text('Error: ${state.error}'));
          } else if (state is FetchStudentsSuccess) {
            return ListView.builder(
              itemCount: state.students.length,
              itemBuilder: (context, index) {
                final student = state.students[index];
                return ListTile(
                  leading: Text("${student.userId}"),
                  subtitle: Text('ID: ${student.id}'),
                );
              },
            );
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const UpdateStudentPage()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
