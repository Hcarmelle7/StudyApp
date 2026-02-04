import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/online_test.png',
              height: 300,
              width: 250,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Various exercises ad quizzes',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.black),
            ),
            const Text(
              'Free correction of exams, play quizzes, observe your evolution',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
