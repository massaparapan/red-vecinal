import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool border;
  final VoidCallback onPressed;

  const AuthButton({
    super.key,
    required this.title,
    required this.foregroundColor,
    required this.border, 
    required this.onPressed,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: border ? Colors.transparent : backgroundColor,
        shadowColor: Colors.transparent,
        foregroundColor: foregroundColor,
        minimumSize: Size(double.infinity, 55),
        side: border ? BorderSide(color: Color(0xFF8FA0FF)) : null,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onPressed,
      child: Text(title, style: TextStyle(fontSize: 20)),
    );
  }
}
