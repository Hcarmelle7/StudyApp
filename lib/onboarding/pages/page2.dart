import 'package:flutter/material.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

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
              'assets/images/online_learning.png',
              height: 300,
              width: 250,
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'online classes',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: Colors.black),
            ),
            const Text(
              'We pay attention to all your studies, get access to all courses posted online by teachers in the world',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w900, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}
