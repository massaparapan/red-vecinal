import 'package:flutter/material.dart';
import 'package:frontend/features/event/models/response/event_response.dart';
import 'package:frontend/shared/widgets/primary_button.dart';

class EventCard extends StatelessWidget {
  final EventResponse event;
  final Function(String) onParticipate;

  const EventCard({
    super.key,
    required this.event,
    required this.onParticipate,
  });

  @override
  Widget build(BuildContext context) {
    final String authorInitial =
        event.createdBy.username.isNotEmpty ? event.createdBy.username[0].toUpperCase() : '?';

    return Card(
      color: Colors.transparent,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: Color(0xFF5988FF),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Expanded(
                  child: Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '- Creado por:',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(width: 6),
                CircleAvatar(
                  radius: 12,
                  backgroundColor: const Color(0xFF5988FF),
                  child: Text(
                    authorInitial,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  event.createdBy.username,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            if (event.description.isNotEmpty)
              Text(
                event.description,
                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.black54,
                ),
              ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 36,
              child: PrimaryButton(
                label: "Participar",
                onPressed: () => onParticipate(event.id),
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
