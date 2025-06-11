import 'package:dio/dio.dart';
import 'package:frontend/core/network/api_client.dart';
import 'package:frontend/features/membership/models/response/community_member_response.dart';
import 'package:frontend/features/membership/models/response/my_membership_response.dart';
import 'package:retrofit/retrofit.dart';

part 'membership_service.g.dart';

@RestApi(baseUrl: '/api/memberships')
abstract class MembershipService {
  factory MembershipService(Dio dio, {String baseUrl}) = _MembershipService;
  factory MembershipService.withDefaults() => MembershipService(ApiClient.instance);

  @GET('/my-community/members')
  Future<List<CommunityMemberResponse>> getCommunityMembers();

  @GET('/me')
  Future<MyMembershipResponse> getMyMembership();
}
