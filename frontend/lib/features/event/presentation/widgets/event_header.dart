import 'package:flutter/material.dart';

class EventHeader extends StatelessWidget {
  const EventHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 5),
            Text(
              'Calendario de Eventos',
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
          ],
        ),
      ),
    );
  }
}