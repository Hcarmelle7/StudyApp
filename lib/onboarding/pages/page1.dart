import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

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
              'assets/images/learning.png',
              height: 300,
              width: 250,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Manage your studies Wisely',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.black),
            ),
            const Text(
              'Set your own study program, get notified on every schedule',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
