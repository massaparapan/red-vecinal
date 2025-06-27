import 'package:flutter/material.dart';
import 'package:frontend/features/event/presentation/widgets/event_bottom_buttons.dart';
import 'package:frontend/features/event/presentation/widgets/event_calendar.dart';
import 'package:frontend/features/event/presentation/widgets/event_header.dart';
import 'package:frontend/features/event/presentation/widgets/event_list.dart';
import 'package:frontend/features/event/repositories/event_respository.dart';
import 'package:frontend/features/event/models/response/event_response.dart';
import 'package:frontend/features/membership/repositories/membership_respository.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  final EventRepository _eventRepository = EventRepository();
  final MembershipRepository _membershipRepository = MembershipRepository();
  
  DateTime today = DateTime.now();
  List<EventResponse> _events = [];
  List<EventResponse> _filteredEvents = [];
  bool _isLoading = true;
  String? _error;
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    _loadEvents();
    _checkAdminStatus();
  }

  void _checkAdminStatus() async {
    try {
      final membership = await _membershipRepository.fetchMyMembership();
      setState(() {
        isAdmin = membership.role == "ADMIN";
      });
    } catch (e) {
      setState(() {
        isAdmin = false;
      });
    }
  }

  Future<void> _loadEvents() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });
      
      final events = await _eventRepository.getAllEvents();
      setState(() {
        _events = events;
        _filteredEvents = events;
        _isLoading = false;
      });
      _filterEventsByDate();
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      today = selectedDay;
    });
    _filterEventsByDate();
  }

  void _filterEventsByDate() {
    final selectedDateStr = "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
    setState(() {
      _filteredEvents = _events.where((event) {
        return event.date.startsWith(selectedDateStr);
      }).toList();
    });
  }

  Future<void> _participateInEvent(String eventId) async {
    try {
      await _eventRepository.participateInEvent(int.parse(eventId));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Te has inscrito al evento exitosamente!'),
          backgroundColor: Color(0xFF5988FF),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al participar: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: _loadEvents,
                color: const Color(0xFF5988FF),
                child: CustomScrollView(
                  slivers: [
                    EventHeader(),
                    EventCalendar(
                      today: today,
                      events: _events,
                      onDaySelected: _onDaySelected,
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Column(
                          children: [
                            Text(
                              'Eventos del ${today.day}/${today.month}/${today.year}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF5988FF),
                              ),
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                    EventList(
                      isLoading: _isLoading,
                      error: _error,
                      filteredEvents: _filteredEvents,
                      onParticipate: _participateInEvent,
                      onRetry: _loadEvents,
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(height: isAdmin ? 130 : 80),
                    ),
                  ],
                ),
              ),
            ),
            EventBottomButtons(
              isAdmin: isAdmin,
              onBack: () => Navigator.pop(context),
              onAddEvent: () => Navigator.pushNamed(context, '/home/admin/events/create'),
            ),
          ],
        ),
      ),
    );
  }
}