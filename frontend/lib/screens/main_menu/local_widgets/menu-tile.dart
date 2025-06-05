import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  
  final IconData icon;
  final String label;
  final Color color;

  const MenuTile({
    super.key,
    required this.icon,
    required this.label,
    required this.color,
  });


  @override
  Widget build(BuildContext context) {
    return Center(                        
      child: SizedBox(                      
        width: 130,                         
        height: 130,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: color, width: 2),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 80, color: color),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}