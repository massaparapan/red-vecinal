import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/features/membership/models/response/community_member_response.dart';
import 'package:frontend/features/membership/models/response/my_membership_response.dart';
import 'package:frontend/features/membership/services/membership_service.dart';

class MembershipRepository {
  final MembershipService _membershipService;
  MembershipRepository() : _membershipService = MembershipService.withDefaults();
  final _storage = FlutterSecureStorage();

  Future<List<CommunityMemberResponse>> getMembers () async {
    return await _membershipService.getCommunityMembers();
  }

  Future<MyMembershipResponse> fetchMyMembership () async {
    try {
      final response = await _membershipService.getMyMembership();

      _storage.write(key: "status", value: response.status);
      _storage.write(key: "role", value: response.role);

      return response;
    } on DioException{
      return MyMembershipResponse(status: null, role: null);
    }
  }

  deleteMember(int membershipId) {}
}