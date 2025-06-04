import 'package:flutter/material.dart';

class AltButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color color;
  final IconData? icon;
  final double width;
  final double height;


  const AltButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.color = const Color(0xFF5988FF), 
    this.icon,
    this.width = 300,
    this.height = 55,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(300, 40),
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          foregroundColor: color,              
          side: BorderSide(color: color),      
        ),
        onPressed: onPressed,
        child:
        icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: color),
                  const SizedBox(width: 8),
                  Text(label, style: TextStyle(color: color)),
                ],
              )
            :
         Text(label, style: TextStyle(color: color)),
      ),
    );
  }
}