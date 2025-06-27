import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/features/membership/models/response/community_member_response.dart';
import 'package:frontend/features/membership/models/response/my_membership_response.dart';
import 'package:frontend/features/membership/services/membership_service.dart';

class MembershipRepository {
  final MembershipService _membershipService;
  MembershipRepository() : _membershipService = MembershipService.withDefaults();
  final _storage = FlutterSecureStorage();

  Future<List<CommunityMemberResponse>> getMembers() async {
    return await _membershipService.getCommunityMembers();
  }

  Future<MyMembershipResponse> fetchMyMembership() async {
    try {
      final response = await _membershipService.getMyMembership();
      await _storage.write(key: "status", value: response.status);
      await _storage.write(key: "role", value: response.role);
      return response;
    } on DioException {
      return MyMembershipResponse(status: null, role: null);
    }
  }

  Future<void> deleteMember(int membershipId) async {
    try {
      await _membershipService.rejectMembership(membershipId);
    } on DioException catch (e) {
      throw Exception('Error al eliminar miembro: ${e.message}');
    }
  }

  Future<void> assignAdmin(int membershipId) async {
    try {
      await _membershipService.assignAdmin(membershipId);
    } on DioException catch (e) {
      throw Exception('Error al asignar administrador: ${e.message}');
    }
  }

  Future<void> unassignRoles(int membershipId) async {
    try {
      await _membershipService.unassignRoles(membershipId);
    } on DioException catch (e) {
      throw Exception('Error al quitar roles: ${e.message}');
    }
  }
}