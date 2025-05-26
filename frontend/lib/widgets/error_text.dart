import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {

  final String text;

  const ErrorText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 15,
        fontWeight:FontWeight.normal,
        color: Colors.red,
      ),
    );
  }
}