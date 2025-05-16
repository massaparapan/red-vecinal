import 'package:flutter/material.dart';

class AuthInputCode extends StatelessWidget {
  const AuthInputCode({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SizedBox(
      height: mediaQuery.size.height * 0.075,
      width: mediaQuery.size.width * 0.115,
      child: TextField(
        expands: true,
        minLines: null,
        maxLines: null,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          hintStyle: TextStyle(fontSize: 20),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
