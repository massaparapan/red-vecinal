import 'package:flutter/material.dart';

class AnnouncementBox extends StatelessWidget {
  final String userName;
  final String time;
  final String message;
  final String tag;
  final String? imageUrl;
  final int likes;

  const AnnouncementBox({
    super.key,
    required this.userName,
    required this.time,
    required this.message,
    required this.tag,
    this.imageUrl,
    required this.likes,
  });

  String getUserInitials() {
    if (userName.isEmpty) return 'J';
    return userName[0].toUpperCase();
  }

  Color getTagColor() {
    switch (tag.toLowerCase()) {
      case 'emergencia':
        return const Color(0xFFFF8C8C);
      case 'reunion':
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
                  userName,
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
          if (imageUrl != null) ...[
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              height: 160,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(6),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: const Center(
                        child: Icon(
                          Icons.image_outlined,
                          size: 40,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
          
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.thumb_up_outlined,
                size: 20,
                color: Colors.grey[600],
              ),
              const SizedBox(width: 4),
              Text(
                likes.toString(),
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            ],
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