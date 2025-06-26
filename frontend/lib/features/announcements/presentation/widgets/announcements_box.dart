import 'package:flutter/material.dart';

class AnnouncementBox extends StatelessWidget {
  final String username;
  final String time;
  final String message;
  final String tag;
  final String? imageUrl;

  const AnnouncementBox({
    super.key,
    required this.username,
    required this.time,
    required this.message,
    required this.tag,
    this.imageUrl,
  });

  String getUserInitials() {
    if (username.isEmpty) return 'J';
    return username[0].toUpperCase();
  }

  Color getTagColor() {
    switch (tag.toLowerCase()) {
      case 'emergencia':
        return const Color(0xFFFF8C8C);
      case 'reunión':
        return const Color(0xFF79DD5F).withOpacity(0.8);
      case 'anuncio':
        return const Color(0xFFFFF28C);
      default:
        return const Color(0xFF9CA3AF);
    }
  }

  IconData getTagIcon() {
    switch (tag.toLowerCase()) {
      case 'emergencia':
        return Icons.warning;
      case 'reunion':
        return Icons.people;
      case 'anuncio':
        return Icons.campaign;
      default:
        return Icons.info;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: const Color(0xFF60A5FA),
                child: Text(
                  getUserInitials(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  username,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 8),
          Text(
            message,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black87,
              height: 1.3,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: getTagColor(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  getTagIcon(),
                  size: 20,
                  color: Colors.black,
                ),
                const SizedBox(width: 4),
                Text(
                  tag,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          const Divider(
            color: Colors.grey,
            thickness: 0.5,
            height: 1,
          ),
        ],
      ),
    );
  }
}