import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:mystudy/onboarding/pages/page1.dart';
import 'package:mystudy/onboarding/pages/page2.dart';
import 'package:mystudy/onboarding/pages/page3.dart';
import 'package:mystudy/router/app_router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(children: [
        PageView(
          controller: _controller,
          onPageChanged: (index) {
            setState(() {
              onLastPage = (index == 2);
            });
          },
          children: const [
            Page1(),
            Page2(),
            Page3(),
          ],
        ),
        Container(
            alignment: const Alignment(0, 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: const Text(
                    'Skip',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey, // Inactive dot color
                    activeDotColor: Colors.deepPurple, // Active dot color
                    dotHeight: 8.0,
                    dotWidth: 8.0,
                    spacing: 8.0,
                  ),
                ),
                onLastPage
                    ? GestureDetector(
                        onTap: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();

                          prefs.setBool('is_first_time_launch', true);

                          context.router.pushAndPopUntil(
                            LoginRoute(),
                            predicate: (router) => false,
                          );
                        },
                        child: const Text(
                          'Done',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 600),
                              curve: Curves.easeInCirc);
                        },
                        child: const Text(
                          'Next',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 32, 52, 226)),
                        ),
                      ),
              ],
            ))
      ]),
    );
  }
}
