import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:mystudy/features/quiz/component/answers/business_logic/get_answer_bloc/get_answer_bloc.dart';
import 'package:mystudy/features/quiz/business_logic/create_quiz_bloc/create_quiz_bloc.dart';
import 'package:mystudy/features/quiz/business_logic/quiz_by_id_bloc/quiz_by_id_bloc.dart';
import 'package:mystudy/features/quiz/data/model/score_model.dart';
import 'package:mystudy/router/app_router.gr.dart';
import 'package:mystudy/core/services/network/service_locator.dart';
import 'package:mystudy/core/widgets/plasma_background.dart';

@RoutePage()
class QuizGameScreen extends StatefulWidget {
  const QuizGameScreen({super.key});

  @override
  State<QuizGameScreen> createState() => _QuizGameScreenState();
}

class _QuizGameScreenState extends State<QuizGameScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  int? _selectedAnswerIndex;
  double progress = 1.0;
  int timeRemaining = 5;
  Duration duration = const Duration();
  int totalSeconds = 0;
  int _score = 0;
  late int? _nQuestions;
  late ConfettiController _confettiController;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    duration = Duration(seconds: timeRemaining);
    totalSeconds = timeRemaining;
    startTimer();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 15));
    _confettiController.play();
    _controller = AnimationController(vsync: this);
  }

  void startTimer() async {
    setState(() {
      timeRemaining = totalSeconds; // Réinitialiser le temps restant
      progress = 1.0; // Réinitialiser la barre de progression
    });

    while (timeRemaining > 0) {
      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      setState(() {
        timeRemaining -= 1;
        progress = timeRemaining / totalSeconds;
      });
    }
    _nextPage();
  }

  void addScore(BuildContext context) {
    final score =
        ScoreModel(id: Random().nextInt(100), score: (_score / _nQuestions!));
    BlocProvider.of<CreateQuizBloc>(context).add(CreateScoreEvent(score));
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
                      '${((_score * 100) / _nQuestions!).toStringAsFixed(1)}% Score',
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
                      'You attempted $_nQuestions questions, and from that $_score is correct! ',
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
                                  : const Text('Terminer'),
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

  @override
  void dispose() {
    _pageController.dispose();
    // _confettiController.dispose();
    _controller.dispose();
    super.dispose();
  }

  int _currentPage = 0;
  void _nextPage() {
    if (_currentPage < _nQuestions!) {
      setState(() {
        _currentPage++;
      });
      _pageController.nextPage(
          duration: const Duration(seconds: 1), curve: Curves.ease);
      startTimer();
    } else {
      // Afficher le score final lorsque toutes les questions ont été répondues
      _showFinalScore();
    }
  }

  @override
  Widget build(BuildContext context)
  {
    return BlocListener<CreateQuizBloc, CreateQuizState>(
      listener: (context, state)
      {
        if (state is CreateScoreSuccess)
        {
          _confettiController.play();
          context.router.pushAndPopUntil(QuizRoute(), predicate: (router) => false);
        }
        else if (state is CreateScoreFailure)
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      child: BlocBuilder<QuizByIdBloc, QuizByIdState>(
        builder: (context, state) {
          if (state is GetQuizLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetQuizFailure) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is GetQuizSuccess) {
            _nQuestions = state.quiz.quiz.nQuestions;
            return Scaffold(
              backgroundColor: Colors.deepPurple,
              // appBar: AppBar(
              //   title: Text(state.quiz.quiz.title),
              // ),
              body: SafeArea(
                child: Stack(
                  children: [
                    ConfettiWidget(
                      confettiController: _confettiController,
                      blastDirectionality: BlastDirectionality.explosive,
                      numberOfParticles: 50,
                      gravity: 0.2,
                      shouldLoop: false,
                    ),
                    Container(
                      color: Colors.black.withValues(alpha: 0.4), // Fond semi-transparent pendant l'animation des confettis
                    ),
                    const PlasmaBackground(),
                    PageView.builder(
                      controller: _pageController,
                      itemCount: state.quiz.questions.length,
                      itemBuilder: (context, index) {
                        final question = state.quiz.questions[index];
                        return Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Column(
                            children: [
                              Container(
                                height: 29,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 25.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Colors.white, width: 2)),
                                child: Stack(
                                  children: [
                                    LinearProgressIndicator(
                                      borderRadius: BorderRadius.circular(12),
                                      value: progress,
                                      minHeight: 29,
                                      backgroundColor: Colors.transparent,
                                      valueColor:
                                          const AlwaysStoppedAnimation<Color>(
                                              Colors.blue),
                                    ),
                                    const Positioned(
                                        right: 5,
                                        child: Icon(
                                          Icons.alarm,
                                          color: Colors.white,
                                        ))
                                  ],
                                ),
                              ),
                              Text(
                                'Question ${index + 1}/${state.quiz.quiz.nQuestions}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                    height: 350,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        color: Colors.transparent,
                                        border: Border.all(
                                            width: 3, color: Colors.white)),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: double.infinity,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      width: 3,
                                                      color: Colors.white)),
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(22),
                                                bottomRight:
                                                    Radius.circular(22),
                                              )),
                                          child: Center(
                                            child: Text(
                                              question.content,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w900),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 22,
                                        ),
                                        BlocBuilder<GetAnswerBloc, GetAnswerState>(
                                          builder: (context, state)
                                          {
                                            if (state is GetAnswerInitial) {
                                              getIt.get<GetAnswerBloc>().add(
                                                  GetAnswerByQuestionEvent(
                                                      questionId: question.id));
                                            }
                                            if (state
                                                is GetAnswerByQuestionLoading) {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            } else if (state
                                                is GetAnswerByQuestionFailure) {
                                              return Center(
                                                  child: Text(
                                                      'Error: ${state.message}'));
                                            } else if (state
                                                is GetAnswerByQuestionSuccess) {
                                              final random = Random();
                                              List shuffledAnswers =
                                                  List.from(state.answers);
                                              shuffledAnswers.shuffle(random);
                                              final threeRandomAnswers =
                                                  shuffledAnswers
                                                      .take(3)
                                                      .toList();

                                              // Shuffle the selected three answers
                                              threeRandomAnswers
                                                  .shuffle(random);
                                              return Expanded(
                                                child: ListView.builder(
                                                    itemCount:
                                                        state.answers.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final answer =
                                                          state.answers[index];
                                                      String answerLabel = [
                                                        'A',
                                                        'B',
                                                        'C',
                                                        'D'
                                                      ][index];
                                                      Color backgroundColor =
                                                          Colors.white;
                                                      if (_selectedAnswerIndex ==
                                                          index) {
                                                        backgroundColor =
                                                            answer.isTrue
                                                                ? Colors.green
                                                                    .shade500
                                                                : Colors.red
                                                                    .shade500;
                                                      }
                                                      return InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            _selectedAnswerIndex =
                                                                index;
                                                            if (answer.isTrue) {
                                                              _score++;
                                                            }
                                                            Future.delayed(
                                                                const Duration(
                                                                    seconds: 1),
                                                                () {
                                                              _nextPage();
                                                            });
                                                          });
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              // Background color for the tile
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          22),
                                                              border: Border.all(
                                                                  width: 3,
                                                                  color:
                                                                      backgroundColor),
                                                            ),
                                                            child: ListTile(
                                                              leading:
                                                                  CircleAvatar(
                                                                backgroundColor:
                                                                    Colors
                                                                        .black,
                                                                child: Text(
                                                                    answerLabel,
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white)),
                                                              ),
                                                              title: Text(
                                                                state
                                                                    .answers[
                                                                        index]
                                                                    .content,
                                                                style: const TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    }),
                                              );
                                            }
                                            return Container();
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
          return const Text('nothing to see here');
        },
      ),
    );
  }
}
