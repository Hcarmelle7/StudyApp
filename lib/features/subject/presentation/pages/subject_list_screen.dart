import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mystudy/features/subject/presentation/widgets/subject_widget.dart';

@RoutePage()
class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 236, 231, 231),

      appBar: AppBar(title: const Center(child: Text('Library'))),
      body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: SubjectWidget(image: AssetImage('assets/images/book.png')),
          ))
      
    );
  }
}
