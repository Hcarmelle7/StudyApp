import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystudy/features/quiz/component/answers/business_logic/create_answer_bloc/create_answer_bloc.dart';
import 'package:mystudy/features/quiz/component/answers/business_logic/get_answer_bloc/get_answer_bloc.dart';
import 'package:mystudy/features/quiz/component/answers/data/models/answer_model.dart';
import 'package:mystudy/router/app_router.gr.dart';
import 'package:mystudy/core/services/network/service_locator.dart';

@RoutePage()
// ignore: must_be_immutable
class CreateAnswerWidget extends StatelessWidget {
  final TextEditingController _answerContentController =
      TextEditingController();

  bool isTrue = false;

  CreateAnswerWidget({super.key});

  void _createAnswer(BuildContext context) async {
    final answer = AnswerModel(
        // answers: answers,
        content: _answerContentController.text,
        isTrue: false
        // teacherId: teacherId,
        );

    BlocProvider.of<CreateAnswerBloc>(context).add(CreateAnswerEvent(answer));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<CreateAnswerBloc, CreateAnswerState>(
        listener: (context, state) {
          if (state is CreateAnswerSuccess) {
            getIt.get<GetAnswerBloc>().add(GetAllAnswersEvent());
            context.router.push(const LevelRoute());
          } else if (state is CreateAnswerFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erreur : ${state.message}')));
          }
        },
        child: Center(
          child: Column(
            children: [
              const Text('Ajouter une réponse',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
              BlocBuilder<CreateAnswerBloc, CreateAnswerState>(
                builder: (context, state) {
                  return ElevatedButton(
                    onPressed: state is CreateAnswerLoading
                        ? null
                        : () => _createAnswer(
                            context), // Désactiver le bouton si en chargement
                    child: state is CreateAnswerLoading
                        ? const CircularProgressIndicator() // Affichez le CircularProgressIndicator
                        : const Text('Créer la question'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
