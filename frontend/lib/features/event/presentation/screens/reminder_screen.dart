import 'package:flutter/material.dart';
import 'package:frontend/features/event/models/response/event_response.dart';
import 'package:frontend/features/event/presentation/widgets/reminder_box.dart';
import 'package:frontend/features/event/repositories/event_respository.dart';
import 'package:frontend/shared/widgets/alt_button.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final EventRepository _eventRepository = EventRepository();
  List<EventResponse> reminders = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _loadMyParticipations();
    });
  }

  Future<void> _loadMyParticipations() async {
    try {
      final participations = await _eventRepository.getMyParticipations();
      setState(() {
        reminders = participations;
      });
    } catch (e) {
      setState(() {
        reminders = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Text(
                'Recordatorios',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Divider(
                color: Color(0xFF5988FF),
                thickness: 3,
                height: 1,
                indent: 3,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: reminders.isEmpty
                    ? const Center(
                        child: Text(
                          "No hay recordatorios disponibles.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: reminders.length,
                        itemBuilder: (context, index) {
                          final event = reminders[index];
                          return ReminderBox(
                            date: DateTime.parse(event.date),
                            description: '${event.title}: ${event.description}',
                          );
                        },
                      ),
              ),
              const SizedBox(height: 10),
              AltButton(
                label: 'Volver',
                onPressed: () {
                  Navigator.pop(context);
                },
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}