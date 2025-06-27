import 'package:dio/dio.dart';
import 'package:frontend/core/network/api_client.dart';
import 'package:frontend/features/announcements/models/request/createAnnouncementDto.dart';
import 'package:frontend/features/announcements/models/response/announcementResponseDto.dart';
import 'package:retrofit/http.dart';

part 'announcements_service.g.dart';

@RestApi(baseUrl: '/api/announcements')
abstract class AnnouncementsService {
  factory AnnouncementsService(Dio dio, {String baseUrl}) = _AnnouncementsService;
  factory AnnouncementsService.withDefaults() => AnnouncementsService(ApiClient.instance);

  @POST("")
  Future<dynamic> createAnnouncement(@Body() CreateAnnouncementDto dto);

  @GET("/my-community")
  Future<List<AnnouncementResponse>> getAnnouncementsByMyCommunity();
}
