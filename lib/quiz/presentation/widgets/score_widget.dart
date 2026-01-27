import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mystudy/quiz/business_logic/score_bloc/score_bloc.dart';

class ScoreWidget extends StatelessWidget {
  const ScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreBloc, ScoreState>(builder: (context, state) {
      if (state is GetAllScoresLoading) {
        return const Center(child: CircularProgressIndicator());
      } else if (state is GetAllScoresFailure) {
        return Center(child: Text('Error: ${state.message}'));
      } else if (state is GetAllScoresSuccess) {
        return ListView.builder(
          itemCount: state.score.length,
          itemBuilder: (context, index) {
            final score = state.score[index];
            final double percentage = score.score;
            Color progressBarColor;
            if (percentage < 0.30) {
              progressBarColor = Colors.red; // Less than 30% - red
            } else if (percentage > 0.60) {
              progressBarColor = Colors.green; // More than 60% - green
            } else {
              progressBarColor = Colors.orange; // Between 30% and 60% - orange
            }

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Score ${index + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${(percentage * 100).toStringAsFixed(0)}%', // Affichage en pourcentage avec une décimale
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: percentage,
                      minHeight: 8,
                      backgroundColor: Colors.grey[300],
                      valueColor:
                          AlwaysStoppedAnimation<Color>(progressBarColor),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
      return Container();
    });
  }
}
