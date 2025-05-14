import 'package:flutter/material.dart';

class DecorativeCircle extends StatelessWidget {
  final double? left;
  final double? right;
  final double? top;
  final double? bottom;
  final double size;
  final List<Color> colors;

  const DecorativeCircle({
    super.key,
    this.left,
    this.right,
    this.top,
    this.bottom,
    required this.colors,
    required this.size
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      top: top,
      left: left,
      right: right,
      bottom: bottom,
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
