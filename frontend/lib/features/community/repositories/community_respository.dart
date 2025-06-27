import 'package:dio/dio.dart';
import 'package:frontend/features/community/models/response/community_preview_response.dart';
import 'package:frontend/features/community/models/request/create_community_request.dart';
import 'package:frontend/features/community/services/community_service.dart';

class CommunityRespository {
  final CommunityService _communityService;
  CommunityRespository() : _communityService = CommunityService.withDefaults();

  Future<List<CommunityPreviewResponse>> getCloseCommunities({
    required double lat,
    required double lon,
  }) async {
    return await _communityService.getCloseCommunities(lat, lon);
  }

  Future<bool> createCommunity({
    required String name,
    required String description,
    required double lat,
    required double lon,
  }) async {
    try {
      await _communityService.createCommunity(
        CreateCommunityRequest(
          name: name,
          description: description,
          lat: lat,
          lon: lon,
        ),
      );
      return true;
    } on DioException catch (e) {
      throw (e.message ?? "Error inesperado");
    }
  }
}
