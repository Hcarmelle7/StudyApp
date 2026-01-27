import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mystudy/router/app_router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingContentWidget extends StatelessWidget {
  final String image;
  final String? title;
  final String description;

  const OnboardingContentWidget({
    super.key,
    required this.image,
    this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 2),
        Image.asset(
          image,
          width: 300,
          height: 300,
        ),
        const Spacer(flex: 2),
        if (title != null)
          Text(
            title!,
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  /// ?????!!!!
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  prefs.setBool('is_first_time_launch', true);

                  context.router.pushAndPopUntil(
                    LoginRoute(),
                    predicate: (router) => false,
                  );
                },
                child: const Text(
                  'Sign In',
                ),
              ),
              Container(
                width: 1,
                height: 15,
                color: Colors.grey,
              ),
              GestureDetector(
                onTap: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  prefs.setBool('is_first_time_launch', true);

                  context.router.pushAndPopUntil(
                    LegisterRoute(),
                    predicate: (router) => false,
                  );
                },
                child: const Text(
                  'Sign Up',
                ),
              )
            ],
          ),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
        const Spacer(),
      ],
    );
  }
}
