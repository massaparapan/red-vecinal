import 'package:flutter/material.dart';

class DecorativeCircle extends StatelessWidget {
  final List<double?> position;
  final List<Color> colors;

  const DecorativeCircle({
    super.key,
    required this.position,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      top: position[0]! * 0.8,
      left: position[2]! * 0.8,
      right: position[3]! * 0.8,
      bottom: position[1]! * 0.8,
      child: Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 0.5,
            colors: [colors[0], colors[1]],
          ),
        ),
      ),
    );
  }
}
