import 'package:flutter/material.dart';

class Service extends StatelessWidget {
  const Service({
    super.key,
    required this.image,
    required this.text,
  });
  final ImageProvider image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(18),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
                color:  Colors.white,
                borderRadius: BorderRadius.circular(5)),
            child: CircleAvatar(
                backgroundColor: Colors.transparent, backgroundImage: image)),
        const SizedBox(
          height: 10,
        ),
        Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
      ],
    );
  }
}
