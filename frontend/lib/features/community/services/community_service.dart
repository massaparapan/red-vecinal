import 'package:dio/dio.dart';
import 'package:frontend/core/network/api_client.dart';
import 'package:frontend/features/community/models/response/community_preview_response.dart';
import 'package:retrofit/http.dart';

part 'community_service.g.dart';

@RestApi(baseUrl: '/api/communities')
abstract class CommunityService {
  factory CommunityService(Dio dio, {String baseUrl}) = _CommunityService;
  factory CommunityService.withDefaults() => CommunityService(ApiClient.instance);

  @GET("/close")
  Future<List<CommunityPreviewResponse>> getCloseCommunities(
    @Query("lat") double lat,
    @Query("lon") double lon,
  );

  @POST("/create")
  Future<void> createCommunity(@Body() createCommunity);
}
