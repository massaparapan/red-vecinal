import 'package:flutter/material.dart';
import 'package:frontend/features/information/presentation/screens/information_view.dart';

class InformationBox extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback? onTap; 
  final int? id; 

  const InformationBox({
    super.key,
    required this.title,
    required this.content,
    this.onTap,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: Color.fromARGB(255, 223, 223, 223),
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(
          title,
          style: const TextStyle(fontSize: 24),
        ),
        trailing: const Icon(
          Icons.chevron_right,
          color: Colors.grey,
        ),
        onTap: onTap ??
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewInformationScreen(
                    title: title,
                    content: content,
                    id: id ?? 0, 
                  ),
                ),
              );
            },
      ),
    );
  }
}
