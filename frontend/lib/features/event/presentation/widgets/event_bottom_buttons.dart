import 'package:flutter/material.dart';
import 'package:frontend/shared/widgets/primary_button.dart';
import 'package:frontend/shared/widgets/alt_button.dart';

class EventBottomButtons extends StatelessWidget {
  final bool isAdmin;
  final VoidCallback onBack;
  final VoidCallback onAddEvent;

  const EventBottomButtons({
    super.key,
    required this.isAdmin,
    required this.onBack,
    required this.onAddEvent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isAdmin) ...[
            PrimaryButton(
              label: "Agregar Evento",
              onPressed: onAddEvent,
              width: double.infinity,
            ),
            const SizedBox(height: 10),
          ],
          AltButton(
            label: 'Volver',
            onPressed: onBack,
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}