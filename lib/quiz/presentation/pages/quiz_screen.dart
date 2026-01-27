import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystudy/quiz/business_logic/quiz_bloc/quiz_bloc.dart';
import 'package:mystudy/quiz/business_logic/quiz_by_id_bloc/quiz_by_id_bloc.dart';
import 'package:mystudy/router/app_router.gr.dart';
import 'package:mystudy/state/service_locator.dart';

@RoutePage()
// ignore: must_be_immutable
class QuizScreen extends StatelessWidget {
  QuizScreen({super.key});
  int? selectedId = 0;

  IconData _getQuizIcon(String title) {
    switch (title.toLowerCase()) {
      case 'maths':
        return Icons.calculate;
      case 'history':
        return Icons.history;
      case 'science':
        return Icons.science;
      case 'literature':
        return Icons.book;
      case 'physics':
        return Icons.device_hub;
      case 'chemistry':
        return Icons.build;
      case 'geography':
        return Icons.map;
      default:
        return Icons.quiz;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizzes'),
      ),
      body: BlocBuilder<QuizBloc, QuizState>(
        builder: (context, state) {
          if (state is QuizInitial) {
            context.read<QuizBloc>().add(GetAllQuizzesEvent());
          }

          if (state is GetAllQuizzesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetAllQuizzesFailure) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is GetAllQuizzesSuccess) {
            return ListView.builder(
              itemCount: state.quizzes.length,
              itemBuilder: (context, index) {
                final quiz = state.quizzes[index];
                final quizIcon = _getQuizIcon(quiz.title);

                return InkWell(
                  onTap: () {
                    selectedId = quiz.id;
                    getIt.get<QuizByIdBloc>().add(GetQuizEvent(id: quiz.id));
                    context.router.push(const GameRoute());
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 16.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 20,
                              child: Icon(
                                quizIcon,
                                color: Colors.purple,
                                size: 30,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    quiz.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    quiz.description,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.deepPurple,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }

          // If no state matches, display this:
          return const Center(child: Text('No data available.'));
        },
      ),
    );
  }
}
