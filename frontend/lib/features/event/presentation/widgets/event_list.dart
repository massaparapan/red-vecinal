import 'package:flutter/material.dart';
import 'package:frontend/features/event/models/response/event_response.dart';
import 'package:frontend/features/event/presentation/widgets/event_card.dart';
import 'package:frontend/shared/widgets/primary_button.dart';

class EventList extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final List<EventResponse> filteredEvents;
  final Function(String) onParticipate;
  final VoidCallback onRetry;

  const EventList({
    super.key,
    required this.isLoading,
    required this.error,
    required this.filteredEvents,
    required this.onParticipate,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const SliverFillRemaining(
        child: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF5988FF),
          ),
        ),
      );
    }

    if (error != null) {
      return SliverFillRemaining(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 48,
                  color: Colors.red,
                ),
                const SizedBox(height: 12),
                Text(
                  'Error al cargar eventos',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red[700],
                  ),
                ),
                const SizedBox(height: 12),
                PrimaryButton(
                  label: "Reintentar",
                  onPressed: onRetry,
                  width: 120,
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (filteredEvents.isEmpty) {
      return const SliverFillRemaining(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.event_busy,
                size: 48,
                color: Colors.grey,
              ),
              SizedBox(height: 12),
              Text(
                'No hay eventos este día',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: EventCard(
              event: filteredEvents[index],
              onParticipate: onParticipate,
            ),
          );
        },
        childCount: filteredEvents.length,
      ),
    );
  }
}