import 'package:flutter/material.dart';
import 'package:mystudy/core/themes/colors/app_colors.dart';

class LevelWidget extends StatelessWidget {
  const LevelWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      width: 50,
      height: 40,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(title),
    );
  }
}
