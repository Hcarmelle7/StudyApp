// lib/screens/register_screen.dart

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystudy/quiz/questions/business_logic/create_question_bloc/create_question_bloc.dart';
import 'package:mystudy/quiz/questions/business_logic/questions_bloc/questions_bloc.dart';
import 'package:mystudy/quiz/answers/data/models/answer_model.dart';
import 'package:mystudy/router/app_router.gr.dart';
import 'package:mystudy/state/service_locator.dart';
import 'package:mystudy/tools/themes/colors/app_colors.dart';
import 'package:mystudy/quiz/questions/data/models/question_model.dart';

import '../../../../auth/business_logic/profile_bloc/profile_bloc.dart';
import '../../../../subject/business_logic/subject_bloc/subject_bloc.dart';

@RoutePage()
// ignore: must_be_immutable
class CreateQuestionPage extends StatefulWidget {
  const CreateQuestionPage({super.key});

  @override
  State<CreateQuestionPage> createState() => _CreateQuestionPageState();
}

class _CreateQuestionPageState extends State<CreateQuestionPage> {
  final TextEditingController _questionContentController =
      TextEditingController();

  final TextEditingController _durationController = TextEditingController();

  String _selectedLevel = 'easy';
  String _selectedType = 'multiple';

  List<AnswerModel> answers = [];

  final TextEditingController _answerContentController =
      TextEditingController();

  String answerContent = '';

  bool isTrue = false;

  final List<String> _listlevel = ['easy', 'medium', 'hard', 'xtrem'];

  final List<String> _listtype = ['multiple', 'bool', 'input'];

  void _createQuestion(BuildContext context) async {
    final question = QuestionModel(
      answers: answers,
      content: _questionContentController.text,
      type: _selectedType,
      level: _selectedLevel,
      duration: _durationController.text,
    );

    BlocProvider.of<CreateQuestionBloc>(context)
        .add(CreateQuestionsEvent(question, answers));
  }

  void addAnswer() {
    setState(() {
      answers.add(AnswerModel(content: _answerContentController.text, isTrue: isTrue));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(title: const Center(child: Text('Create Questions'))),
      body: BlocListener<CreateQuestionBloc, CreateQuestionState>(
        listener: (context, state) {
          if (state is CreateQuestionSuccess) {
            getIt.get<QuestionsBloc>().add(GetAllQuestionsEvent());
            context.router.push(const QuestionListRoute());
          } else if (state is CreateQuestionFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erreur : ${state.message}')));
            context.router.push(LoginRoute());
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _questionContentController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      filled: true,
                      fillColor: Colors.purple.shade100,
                      labelText: 'Contenu',
                      labelStyle: const TextStyle(color: AppColors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25))),
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 20),
                TextField(
                  controller: _durationController,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      filled: true,
                      fillColor: Colors.purple.shade100,
                      labelText: 'Durée',
                      labelStyle: const TextStyle(color: AppColors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25))),
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  initialValue: _selectedType,
                  items: _listtype.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    _selectedType = newValue!;
                  },
                  decoration:
                      const InputDecoration(labelText: 'Type de question'),
                ),
                DropdownButtonFormField<String>(
                  initialValue: _selectedLevel,
                  items: _listlevel.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    _selectedLevel = newValue!;
                  },
                  decoration:
                      const InputDecoration(labelText: 'Niveau de difficulté'),
                ),

                // Section pour ajouter une réponse
                const Text('Ajouter une réponse',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextFormField(
                  decoration:
                      const InputDecoration(labelText: 'Contenu de la réponse'),
                  controller: _answerContentController,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isTrue,
                      onChanged: (value) {
                        isTrue = value!;
                      },
                    ),
                    const Text('Est-ce la bonne réponse?')
                  ],
                ),
                const SizedBox(height: 6.0),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: addAnswer,
                  child: const Text('Ajouter cette réponse', style: TextStyle(color: Colors.white),),
                ),

                const SizedBox(height: 16.0),

                // Affichage de la liste des réponses ajoutées
                const Text('Réponses ajoutées:',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ...answers.map((answer) => ListTile(
                      title: Text(answer.content),
                      trailing: answer.isTrue
                          ? const Icon(Icons.check, color: Colors.green)
                          : null,
                    )),

                const SizedBox(height: 16.0),
                BlocBuilder<CreateQuestionBloc, CreateQuestionState>(
                  builder: (context, state) {
                    return ElevatedButton(style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                      onPressed: state is CreateQuestionLoading
                          ? null
                          : () => _createQuestion(
                              context), // Désactiver le bouton si en chargement
                      child: state is CreateQuestionLoading
                          ? const CircularProgressIndicator() // Affichez le CircularProgressIndicator
                          : const Text('Créer la question',style: TextStyle(color: Colors.white)),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(items:  [
        BottomNavigationBarItem(icon: InkWell(onTap: () {
          getIt.get<ProfileBloc>().add(GetCurrentUserEvent());
          context.router.pushAndPopUntil(const TeacherBoardRoute(), predicate: (router) => false);
        },child: const Icon(Icons.home)), label: 'home'),
        BottomNavigationBarItem(icon: InkWell(onTap: (){
          getIt.get<SubjectBloc>().add(GetAllSubjectEvent());
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
