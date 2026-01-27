import 'package:flutter/material.dart';
import 'package:mystudy/onboarding1/onboarding_content_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: 12,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: PageView(
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                children: const [
                  OnboardingContentWidget(
                    image: 'asserts/images/learning.png',
                    title: 'Welcome to Future Market',
                    description:
                        'Lorem Ipsum Dolor Sit Amet Consectetur Adipisicing Elit',
                  ),
                  OnboardingContentWidget(
                    image: 'asserts/images/online_learning.png',
                    title: 'Lorconsectetur adipisicing',
                    description:
                        'Lorem Ipsum Dolor Sit Amet Consectetur Adipisicing Elit',
                  ),
                  OnboardingContentWidget(
                    image: 'asserts/images/online_test.png',
                    title: 'Lorem ipsum dolor sit amet',
                    description:
                        'Lorem Ipsum Dolor Sit Amet Consectetur Adipisicing Elit',
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    width: 60,
                    height: 4,
                    color: currentPage == 0 ? Colors.black : Colors.grey,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    width: 60,
                    height: 4,
                    color: currentPage == 1 ? Colors.black : Colors.grey,
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    width: 60,
                    height: 4,
                    color: currentPage == 2 ? Colors.black : Colors.grey,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
