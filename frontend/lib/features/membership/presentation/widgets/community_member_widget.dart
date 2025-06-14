import 'package:flutter/material.dart';

class CommunityMemberWidget extends StatelessWidget {
  final String username;
  final String imageUrl;
  final VoidCallback onDelete;
  final VoidCallback onAscend;

  const CommunityMemberWidget({
    super.key,
    required this.username,
    required this.onDelete,
    required this.onAscend,
    this.imageUrl = '',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
            backgroundColor: Colors.blue[100],
            child: imageUrl.isEmpty
                ? Text(
                    username[0].toUpperCase(),
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              username,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: onDelete,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              foregroundColor: Colors.white,
            ),
            child: const Text("Eliminar"),
          ),
          const SizedBox(width: 8),
          ElevatedButton(
            onPressed: onAscend,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              foregroundColor: Colors.white,
            ),
            child: const Text("Asing Admin"),
          ),
        ],
      ),
    );
  }
}