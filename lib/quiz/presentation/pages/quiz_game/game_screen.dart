import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mystudy/quiz/answers/data/models/answer_model.dart';
import 'package:mystudy/quiz/business_logic/quiz_by_id_bloc/quiz_by_id_bloc.dart';
import 'package:mystudy/quiz/questions/data/models/question_model.dart';
import 'package:mystudy/tools/widgets/plasma_background.dart';

import '../../../../router/app_router.gr.dart';
import '../../../business_logic/create_quiz_bloc/create_quiz_bloc.dart';
import '../../../data/model/score_model.dart';

@RoutePage()
class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  PageController _pageController = new PageController();
  ConfettiController _confettiController = new ConfettiController();
  late AnimationController _controller;

  double progress = 1.0;
  int _NQuestions = 2;
  bool isStartime = false;

  int totalSeconds = 10;
  int timeRemaining = 10;

  List<QuestionModel> data = [];
  int _score = 0;

  bool isStart = false;

  int? indexSelect;

  int currentPage = 0;
  void _nextPage() {
    if (currentPage < data.length - 1) {
      _pageController.nextPage(
          duration: const Duration(seconds: 1), curve: Curves.ease);
      startTimer();
    } else {
      // Afficher le score final lorsque toutes les questions ont été répondues
      _showFinalScore();
    }
  }

  void startTimer() async {
    timeRemaining = totalSeconds;
    indexSelect = null;

    while (timeRemaining > 0) {
      await Future.delayed(Duration(seconds: 1));
      timeRemaining--;
      progress = timeRemaining / totalSeconds;

      refresh();
    }
    if (indexSelect == null) _nextPage();
  }

  void addScore(BuildContext context) {
    final score =
        ScoreModel(id: Random().nextInt(100), score: (_score / _NQuestions));
    BlocProvider.of<CreateQuizBloc>(context).add(CreateScoreEvent(score));
  }

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          const PlasmaBackground(),
          initBlocBluilder(),
          Center(
            child: _bodyGame(),
          ),
        ],
      )),
    );
  }

  //body
  Widget _bodyGame() {
    for (var value in data)
      print(value.content + " VS: ${value.answers.length}");

    print("mes data : $data");
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: PageView.builder(
        itemBuilder: (BuildContext context, int index) {
          currentPage = index;
          return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: data.isNotEmpty
                  ? [
                      _questionDuration(),
                      SizedBox(height: 35,),
                      _quizContent(data[index]),
                      getCustomButton()
                    ]
                  : []);
        },
        controller: _pageController,
      ),
    );
  }

  Widget getCustomButton() {
    return MaterialButton(
      onPressed: () {
        startTimer();
      },
      child: Icon(
        Icons.build,
        color: Colors.white,
      ),
    );
  }

  Widget _questionDuration() {
    return Container(
      height: 29,
      margin: const EdgeInsets.symmetric(vertical: 25.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white, width: 2)),
      child: Stack(
        children: [
          LinearProgressIndicator(
            borderRadius: BorderRadius.circular(12),
            value: progress,
            minHeight: 29,
            backgroundColor: Colors.transparent,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          const Positioned(
              right: 5,
              child: Icon(
                Icons.alarm,
                color: Colors.white,
              ))
        ],
      ),
    );
  }

  Widget initBlocBluilder() {
    return BlocListener<CreateQuizBloc, CreateQuizState>(
        listener: (context, state) {
      if (state is CreateScoreSuccess) {
        _confettiController.play();
        context.router
            .pushAndPopUntil(QuizRoute(), predicate: (router) => false);
      } else if (state is CreateScoreFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${state.message}')),
        );
      }
    }, child:
            BlocBuilder<QuizByIdBloc, QuizByIdState>(builder: (context, state) {
      //if (state is QuizByIdInitial) {
      //getIt.get<QuizByIdBloc>().add(GetQuizEvent(id: 2));
      //}

      if (state is GetQuizLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is GetQuizFailure) {
        return Center(child: Text('Error: ${state.message}'));
      } else if (state is GetQuizSuccess) {
        _NQuestions = state.quiz.quiz.Nquestions!;
        data = state.quiz.questions;

        if (!isStart) {
          isStart = true;
          startTimer();
          Future.delayed(const Duration(milliseconds: 100), () {
            refresh();
          });
        }

        return Container();
      }

      return Container();
    }));
  }

  Widget _quizContent(QuestionModel question) {
    return Container(
      height: 380,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.transparent,
          border: Border.all(width: 3, color: Colors.white)),
      child: Column(
        children: [
          questionContainer(question),
          SizedBox(
            height: 12,
          ),
          ...List<Widget>.generate(
              question.answers.length > 3 ? 3 : question.answers.length,
              (int index) {
            return answerContainer(question.answers[index], index);
          })
        ],
      ),
    );
  }

  Widget questionContainer(QuestionModel question) {
    return Container(
      width: double.infinity,
      height: 100,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(width: 3, color: Colors.white)),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(22),
            bottomRight: Radius.circular(22),
          )),
      child: Center(
          child: Text(
        question.content,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20),
      )),
    );
  }

  Widget answerContainer(AnswerModel answer, int index) {
    List<String> tab = ['A', 'B', 'C', 'D', 'E', 'F'];

    return Container(
      padding: EdgeInsets.all(5.0),
      margin: EdgeInsets.all(5.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.black,
          child: Text(tab[index],
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
        ),
        title: Text(
          answer.content,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w900),
        ),
        onTap: () {
          if (indexSelect != null) return;
          indexSelect = index;

          if (answer.isTrue) {
            _score++;
          }

          refresh();

          Future.delayed(const Duration(seconds: 1), () {
            _nextPage();
          });
        },
      ),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
          border: Border.all(
              color: indexSelect == null
                  ? Colors.white
                  : indexSelect != index
                      ? Colors.white
                      : answer.isTrue
                          ? Colors.green
                          : Colors.red,
              width: 3.0)),
    );
  }

  void _showFinalScore() {
    //demarrer les confettis en affichat la dialog
    _confettiController.play();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Stack(
            children: [
              Container(
                height: 450,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.purple.shade800,
                      Colors.purple.shade600,
                      Colors.purple,
                      Colors.blue.shade700
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/animations/trophy_cup.json',
                      height: 135,
                      width: 200,
                      controller: _controller,
                      onLoaded: (composition) {
                        _controller.duration = composition.duration;
                        _controller.forward();
                      },
                    ),
                    const Text(
                      'Congrats!',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Affichage du score
                    Text(
                      '${((_score * 100) / _NQuestions).toStringAsFixed(1)}% Score',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'quiz completed Successfully.',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'You attempted $_NQuestions questions, and from that $_score is correct! ',
                      style: const TextStyle(
                        // fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 43, 233, 53),
                      ),
                    ),
                    const SizedBox(height: 30),
                    // Bouton pour revenir ou refaire le quiz
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BlocBuilder<CreateQuizBloc, CreateQuizState>(
                          builder: (context, state) {
                            return ElevatedButton(
                              onPressed: state is CreateScoreLoading
                                  ? null
                                  : () {
                                      addScore(context);
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: state is CreateScoreLoading
                                  ? const CircularProgressIndicator() // Affichez le CircularProgressIndicator
                                  : const Text('Terminer',
                                      style: TextStyle(color: Colors.white)),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Confetti
              ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                numberOfParticles: 50,
                gravity: 0.3,
                shouldLoop: false,
              ),
            ],
          ),
        );
      },
    );
  }

  void refresh() => setState(() {});
}
