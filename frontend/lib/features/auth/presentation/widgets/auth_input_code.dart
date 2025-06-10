import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthInputCode extends StatefulWidget {
  final TextEditingController? controller;

  const AuthInputCode({super.key, this.controller});

  @override
  State<AuthInputCode> createState() => _AuthInputCodeState();
}

class _AuthInputCodeState extends State<AuthInputCode> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return SizedBox(
      height: mediaQuery.size.height * 0.06,
      width: mediaQuery.size.width * 0.09,
      child: TextField(
        controller: widget.controller,
        expands: true,
        minLines: null,
        maxLines: null,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          hintStyle: TextStyle(fontSize: 20),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
      ),
    );
  }
}
