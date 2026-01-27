import 'package:flutter/material.dart';
import 'package:sa3_liquid/liquid/plasma/plasma.dart';

class PlasmaBackground extends StatelessWidget {
  const PlasmaBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black, //dee1ec//fffbf3//f3eded
        backgroundBlendMode: BlendMode.srcOver,
      ),
      child: const PlasmaRenderer(
        type: PlasmaType.bubbles,
        particles: 50,
        color: Colors.purple,
        blur: 0,
        size: 0.2,
        speed: 0.8,
        offset: 1.41,
        blendMode: BlendMode.plus,
        particleType: ParticleType.atlas,
        variation1: 0,
        variation2: 0,
        variation3: 0,
        rotation: 0.79,
      ),
    );
  }
}
