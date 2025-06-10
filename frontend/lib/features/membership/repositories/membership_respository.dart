import 'package:frontend/features/membership/models/response/community_member_response.dart';
import 'package:frontend/features/membership/services/membership_service.dart';

class MembershipRespository {
  final MembershipService _membershipService;
  MembershipRespository() : _membershipService = MembershipService.withDefaults();

  Future<List<CommunityMemberResponse>> getMembers () {
    return _membershipService.getCommunityMembers();
  }
}