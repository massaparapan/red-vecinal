import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:frontend/features/event/models/response/event_response.dart';

class EventCalendar extends StatelessWidget {
  final DateTime today;
  final List<EventResponse> events;
  final Function(DateTime, DateTime) onDaySelected;

  const EventCalendar({
    super.key,
    required this.today,
    required this.events,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Card(
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: const BorderSide(
              color: Color(0xFF5988FF),
              width: 1,
            ),
          ),
          child: TableCalendar(
            locale: 'ES',
            focusedDay: today,
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
              titleTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5988FF),
              ),
            ),
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: const Color(0xFF5988FF),
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: const Color(0xFF5988FF).withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            selectedDayPredicate: (day) => isSameDay(today, day),
            onDaySelected: onDaySelected,
            eventLoader: (day) {
              final dayStr = "${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')}";
              return events.where((event) => event.date.startsWith(dayStr)).toList();
            },
          ),
        ),
      ),
    );
  }
}