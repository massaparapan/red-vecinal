import 'package:flutter/material.dart';
import 'package:frontend/services/membership/membership_service.dart';

class MembersScreen extends StatelessWidget {
  final _membershipService = MembershipService();

  MembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Miembros')),
      body: SafeArea(
        child: FutureBuilder<List<Member>>(
          future: _membershipService.getMembers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No hay miembros.'));
            } else {
              final members = snapshot.data!;
              return ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final member = members[index];
                  return ListTile(
                    leading: CircleAvatar(child: Text(member.username[0].toUpperCase())),
                    title: Text(member.username)
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

class Member {
  final int id;
  final String username;
  final String role;

  Member({required this.id, required this.username, required this.role});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      username: json['username'],
      role: json['role'],
    );
  }
}