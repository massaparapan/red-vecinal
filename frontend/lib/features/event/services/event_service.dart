import 'package:dio/dio.dart';
import 'package:frontend/core/network/api_client.dart';
import 'package:frontend/features/event/models/request/event_create_request.dart';
import 'package:frontend/features/event/models/response/event_response.dart';
import 'package:retrofit/http.dart';

part 'event_service.g.dart';

@RestApi(baseUrl: '/api/events')
abstract class EventService {
  factory EventService(Dio dio, {String baseUrl}) = _EventService;
  factory EventService.withDefaults() => EventService(ApiClient.instance);

  @GET("/my-community")
  Future<List<EventResponse>> getAllEvents();

  @POST("")
  Future<EventResponse> createEvent(@Body() EventCreateRequest request);

  @DELETE("/{id}")
  Future<String> deleteEvent(@Path("id") int id);

  @POST("/participate/{id}")
  Future<String> participateInEvent(@Path("id") int id);

  @GET("/my-participations")
  Future<List<EventResponse>> getMyParticipations();
}