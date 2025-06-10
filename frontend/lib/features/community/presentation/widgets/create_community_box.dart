
import 'package:flutter/material.dart';

class CreateCommunityBox extends StatelessWidget {
  final double width;
  final String hintText;
  final VoidCallback onPressed;
  final Widget? icon;
  final TextEditingController controller;
  final int minLines;
  final int maxLines;

  const CreateCommunityBox({
    super.key,
    required this.width,
    required this.hintText,
    required this.onPressed,
    required this.controller,
    this.minLines = 1,
    this.maxLines = 1,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        minLines: minLines,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hintText,
          suffixIcon: icon,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}