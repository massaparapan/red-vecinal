import 'package:flutter/material.dart';

class AuthInputCode extends StatelessWidget {
  const AuthInputCode({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      width: 50,
      
      child: TextField(
        expands: true,
        minLines: null,
        maxLines: null,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15)
          ),
          hintStyle: TextStyle(fontSize: 20),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
