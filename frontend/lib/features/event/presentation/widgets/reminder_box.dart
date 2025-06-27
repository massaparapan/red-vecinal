import 'package:flutter/material.dart';

class ReminderBox extends StatelessWidget {
  final DateTime date;
  final String description;

  const ReminderBox({
    super.key,
    required this.date,
    required this.description,
  });

  String getFormattedDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    final year = date.year.toString();
    return "$day-$month-$year";
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = getFormattedDate(date);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color.fromARGB(255, 223, 223, 223),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_month_rounded, color: Colors.orange),
              const SizedBox(width: 8),
              Text(
                formattedDate,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
