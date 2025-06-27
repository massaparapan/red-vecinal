import 'package:dio/dio.dart';
import 'package:frontend/features/event/models/request/event_create_request.dart';
import 'package:frontend/features/event/models/response/event_response.dart';
import 'package:frontend/features/event/services/event_service.dart';

class EventRepository {
  final EventService _eventService;

  EventRepository() : _eventService = EventService.withDefaults();

  Future<List<EventResponse>> getAllEvents() async {
    try {
      return await _eventService.getAllEvents();
    } on DioException catch (e) {
      throw Exception('Error al obtener eventos: ${e.message}');
    }
  }

  Future<EventResponse> createEvent(EventCreateRequest request) async {
    try {
      return await _eventService.createEvent(request);
    } on DioException catch (e) {
      throw Exception('Error al crear evento: ${e.message}');
    }
  }

  Future<String> deleteEvent(int id) async {
    try {
      return await _eventService.deleteEvent(id);
    } on DioException catch (e) {
      throw Exception('Error al eliminar evento: ${e.message}');
    }
  }

  Future<String> participateInEvent(int id) async {
    try {
      return await _eventService.participateInEvent(id);
    } on DioException catch (e) {
      throw Exception('Error al participar en evento: ${e.message}');
    }
  }

  Future<List<EventResponse>> getMyParticipations() async {
    try {
      return await _eventService.getMyParticipations();
    } on DioException catch (e) {
      throw Exception('Error al obtener participaciones: ${e.message}');
    }
  }
}