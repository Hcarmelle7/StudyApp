// lib/screens/create_quiz_screen.dart

import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystudy/quiz/business_logic/create_quiz_bloc/create_quiz_bloc.dart';
import 'package:mystudy/quiz/data/model/quiz_model.dart';
import 'package:mystudy/quiz/questions/data/models/question_model.dart';
import 'package:mystudy/quiz/answers/data/models/answer_model.dart';
import 'package:mystudy/router/app_router.gr.dart';
import 'package:mystudy/tools/themes/colors/app_colors.dart';

@RoutePage()
class CreateQuizPage extends StatefulWidget {
  const CreateQuizPage({super.key});

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {
  final TextEditingController _quizTitleController = TextEditingController();
  final TextEditingController _quizDescriptionController =
      TextEditingController();

  final TextEditingController _questionContentController =
      TextEditingController();

  final TextEditingController _durationController = TextEditingController();

  List<QuestionModel> questions = [];

  final TextEditingController _answerContentController =
      TextEditingController();

  List<AnswerModel> answers = [];

  String answerContent = '';

  bool isTrue = false;

  String selectedLevel = 'easy';
  String selectedType = 'multiple';
  final List<String> listLevel = ['easy', 'medium', 'hard', 'xtrem'];

  final List<String> listType = ['multiple', 'bool', 'input'];

  void addQuestion() {
    setState(() {
      questions.add(QuestionModel(
          content: _questionContentController.text,
          type: selectedType,
          level: selectedLevel,
          duration: _durationController.text,
          answers: answers));
    });
  }

  void addAnswer() {
    setState(() {
      answers.add(
          AnswerModel(content: _answerContentController.text, isTrue: isTrue));
    });
  }

  void _createQuiz(BuildContext context) {
    final quiz = QuizModel(
       id: Random().nextInt(100),
        title: _quizTitleController.text,
        description: _quizDescriptionController.text,
        questions: questions);

    BlocProvider.of<CreateQuizBloc>(context)
        .add(CreateQuizzesEvent( quiz,  questions));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(title: const Text('Créer un Quiz')),
      body: BlocListener<CreateQuizBloc, CreateQuizState>(
        listener: (context, state) {
          if (state is CreateQuizSuccess) {
            // context.router.push(const QuizListRoute());
            print('object');
          } else if (state is CreateQuizFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Erreur : ${state.message}')),
            );
            context.router.push(LoginRoute());
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _quizTitleController,
                  decoration: InputDecoration(
                    labelText: 'Titre du Quiz',
                    prefixIcon: const Icon(Icons.title),
                    fillColor: AppColors.primary,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _quizDescriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    prefixIcon: const Icon(Icons.description),
                    fillColor: AppColors.primary,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Section to add questions dynamically
                const Text(
                  'Questions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),

                // Dynamic list of questions
                ...questions.asMap().entries.map((entry) {
                  int index = entry.key;
                  QuestionModel question = entry.value;
                  return buildQuestionField(index, question);
                }),

                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: addQuestion,
                  child: const Text('Ajouter une question'),
                ),

                const SizedBox(height: 20),
                BlocBuilder<CreateQuizBloc, CreateQuizState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: state is CreateQuizLoading
                          ? null
                          : () => _createQuiz(context),
                      child: state is CreateQuizLoading
                          ? const CircularProgressIndicator()
                          : const Text('Créer le Quiz'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildQuestionField(int questionIndex, QuestionModel question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _questionContentController,
          decoration: InputDecoration(
            labelText: "Contenu de la question ${questionIndex + 1}",
            prefixIcon: const Icon(Icons.question_answer),
            fillColor: AppColors.primary,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _durationController,
          decoration: InputDecoration(
            labelText: "Durée",
            prefixIcon: const Icon(Icons.timer),
            fillColor: AppColors.primary,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          initialValue: question.type,
          items: listType.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            selectedType = newValue!;
          },
          decoration: const InputDecoration(labelText: 'Type de question'),
        ),
        DropdownButtonFormField<String>(
          initialValue: question.level,
          items: listLevel.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            selectedLevel = newValue!;
          },
          decoration: const InputDecoration(labelText: 'Niveau de difficulté'),
        ),
        const SizedBox(height: 10),

        // Section for adding answers to each question
        const Text('Réponses', style: TextStyle(fontSize: 16)),
        ...question.answers.asMap().entries.map((entry) {
          int answerIndex = entry.key;
          AnswerModel answer = entry.value;
          return buildAnswerField(questionIndex, answerIndex, answer);
        }),
        ElevatedButton(
          onPressed: addAnswer,
          child: const Text('Ajouter une réponse'),
        ),
        const Divider(),
      ],
    );
  }

  Widget buildAnswerField(
      int questionIndex, int answerIndex, AnswerModel answer) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            initialValue: answer.content,
            // onChanged: (value) { answer.content = value},
            decoration:
                InputDecoration(labelText: "Réponse ${answerIndex + 1}"),
          ),
        ),
        Checkbox(
          value: isTrue,
          onChanged: (value) {
            isTrue = value!;
          },
        ),
        const Text("Correct"),
      ],
    );
  }
}
