import 'package:flutter/material.dart';
import 'package:frontend/features/events/presentation/widgets/reminder_box.dart';
import 'package:frontend/shared/widgets/alt_button.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({super.key});

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  List<String> reminders = []; 

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        reminders = [
          "Recordatorio 1: Reunión de equipo a las 10 AM.",
          "Recordatorio 2: Entrega del informe mensual el viernes.",
          "Recordatorio 3: Revisión de código programada para mañana.",
          "Recordatorio 4: Actualización de la base de datos el sábado.",
          "Recordatorio 5: Capacitación sobre nuevas herramientas el lunes.",
          "Recordatorio 6: Reunión con el cliente a las 3 PM.",
          "Recordatorio 7: Presentación del proyecto el miércoles.",
          "Recordatorio 8: Revisión de presupuesto el jueves.",
          "Recordatorio 9: Evento de networking el próximo martes.",
          "Recordatorio 10: Fecha límite para la solicitud de vacaciones el viernes.",
        ];
      });
    });
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
                          return ReminderBox(
                            date: DateTime.now(), 
                            description: reminders[index],
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
