import 'dart:math';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mystudy/quiz/answers/data/models/answer_model.dart';
import 'package:mystudy/quiz/business_logic/create_quiz_bloc/create_quiz_bloc.dart';
import 'package:mystudy/quiz/data/model/quiz_model.dart';
import 'package:mystudy/quiz/questions/business_logic/questions_bloc/questions_bloc.dart';
import 'package:mystudy/quiz/questions/data/models/question_model.dart';
import 'package:mystudy/router/app_router.gr.dart';
import 'package:mystudy/state/service_locator.dart';
import 'package:mystudy/tools/themes/colors/app_colors.dart';

@RoutePage()
class CreateQuizScreen extends StatefulWidget {
  const CreateQuizScreen({super.key});

  @override
  State<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final TextEditingController _quizTitleController = TextEditingController();
  final TextEditingController _quizDescriptionController =
      TextEditingController();

  List<QuestionModel> questions = [];
  List<AnswerModel> answers = [];

  final TextEditingController questionContentController =
      TextEditingController();
  final TextEditingController questionDurationController =
      TextEditingController();
  final TextEditingController answerContentController = TextEditingController();

  String _selectedType = 'multiple';
  double _levelValue = 0.0;
  bool isTrue = false;

  final List<String> _listType = ['multiple', 'bool', 'input'];
  final List<String> _listLevel = ['easy', 'medium', 'hard', 'xtrem'];
  final List<Color> _levelColors = [
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.red,
  ];

  void _updateLevelValue(double value) {
    setState(() {
      _levelValue = value;
    });
  }

  void addAnswer() {
    setState(() {
      answers.add(
        AnswerModel(content: answerContentController.text, isTrue: isTrue),
      );
      answerContentController.clear();
      isTrue = false; // Reset the checkbox
    });
  }

  void addQuestion() {
    setState(() {
      questions.add(
        QuestionModel(
          content: questionContentController.text,
          type: _selectedType,
          level: _listLevel[_levelValue.toInt()],
          duration: questionDurationController.text,
          answers: answers,
        ),
      );
      questionContentController.clear();
      questionDurationController.clear();
      answers = []; // Reset answers for the next question
    });
  }

  void _createQuiz(BuildContext context) {
    final quiz = QuizModel(
      id: Random().nextInt(100),
      title: _quizTitleController.text,
      description: _quizDescriptionController.text,
      questions: questions,
    );

    BlocProvider.of<CreateQuizBloc>(context)
        .add(CreateQuizzesEvent(quiz, questions));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Quiz'),
        backgroundColor: Colors.purple.shade200,
      ),
      body: BlocListener<CreateQuizBloc, CreateQuizState>(
        listener: (context, state) {
          if (state is CreateQuizSuccess) {
            getIt.get<QuestionsBloc>().add(GetAllQuestionsEvent());
            context.router.push(const QuestionListRoute());
          } else if (state is CreateQuizFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildQuizDetailsCard(),
                const SizedBox(height: 20),
                _buildQuestionFormCard(),
                const SizedBox(height: 20),
                _buildQuestionList(),
                const SizedBox(height: 20),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuizDetailsCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Quiz Details',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _quizTitleController,
              decoration: const InputDecoration(
                labelText: 'Quiz Title',
                prefixIcon: Icon(Icons.title),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _quizDescriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                prefixIcon: Icon(Icons.description),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionFormCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Add a Question',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: questionContentController,
              decoration: const InputDecoration(
                labelText: 'Question Content',
                prefixIcon: Icon(Icons.question_answer),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: questionDurationController,
              decoration: const InputDecoration(
                labelText: 'Question Duration (seconds)',
                prefixIcon: Icon(Icons.timer),
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              initialValue: _selectedType,
              items: _listType.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                _selectedType = newValue!;
              },
              decoration: const InputDecoration(labelText: 'Question Type'),
            ),
            const SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Difficulty Level',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Slider(
                  value: _levelValue,
                  min: 0,
                  max: (_listLevel.length - 1).toDouble(),
                  divisions: _listLevel.length - 1,
                  onChanged: _updateLevelValue,
                  activeColor: _levelColors[_levelValue.toInt()],
                  label: _listLevel[_levelValue.toInt()],
                ),
                Text(
                  _listLevel[_levelValue.toInt()],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: _levelColors[_levelValue.toInt()],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Add Answers',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: answerContentController,
              decoration: const InputDecoration(labelText: 'Answer Content'),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Checkbox(
                  value: isTrue,
                  onChanged: (value) {
                    setState(() {
                      isTrue = value!;
                    });
                  },
                ),
                const Text('Correct Answer'),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.dark,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: addAnswer,
                    child: const Text(
                      'Add Answer',
                      style: TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
            _buildAnswerList(),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: addQuestion,
              child: const Text(
                'Add Question',
                style: TextStyle(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Questions Added:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ...questions.asMap().entries.map((entry) {
          int index = entry.key;
          QuestionModel question = entry.value;
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ListTile(
              title: Text(
                question.content,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  'Type: ${question.type} | Level: ${question.level} | Duration: ${question.duration}s'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  setState(() {
                    questions.removeAt(index);
                  });
                },
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildAnswerList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Added Answers:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        ...answers.asMap().entries.map((entry) {
          int index = entry.key;
          AnswerModel answer = entry.value;
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: ListTile(
              title: Text(answer.content),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (answer.isTrue)
                    const Icon(Icons.check, color: Colors.green),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        answers.removeAt(index);
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<CreateQuizBloc, CreateQuizState>(
      builder: (context, state) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.dark,
            minimumSize: const Size(double.infinity, 50),
          ),
          onPressed:
              state is CreateQuizLoading ? null : () => _createQuiz(context),
          child: state is CreateQuizLoading
              ? const CircularProgressIndicator()
              : const Text(
                  'Submit Quiz',
                  style: TextStyle(color: AppColors.white),
                ),
        );
      },
    );
  }
}
