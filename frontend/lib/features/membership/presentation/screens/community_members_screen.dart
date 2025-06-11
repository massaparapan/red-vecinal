import 'package:flutter/material.dart';
import 'package:frontend/features/membership/models/response/community_member_response.dart';
import 'package:frontend/features/membership/repositories/membership_respository.dart';

class CommunityMembersScreen extends StatefulWidget {
  const CommunityMembersScreen({super.key});

  @override
  State<CommunityMembersScreen> createState() => _CommunityMembersScreenState();
}

class _CommunityMembersScreenState extends State<CommunityMembersScreen> {
  final _membershipRepository = MembershipRepository();
  late Future<List<CommunityMemberResponse>> _futureCommunityMembers;

  @override
  void initState() {
    super.initState();
    _futureCommunityMembers = _membershipRepository.getMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Miembros de la comunidad')),
      body: FutureBuilder<List<CommunityMemberResponse>>(
        future: _futureCommunityMembers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No hay miembros en la comunidad.'));
          } else {
            final members = snapshot.data!;
            return ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];
                return ListTile(
                  title: Text(member.username),
                  subtitle: Text('Rol: ${member.role}'),
                  onTap: () {
                    print('ID del miembro: ${member.id}');
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}