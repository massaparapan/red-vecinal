import 'package:flutter/material.dart';

class CommunityMemberWidget extends StatelessWidget {
  final String username;

  const CommunityMemberWidget({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(child: CircleAvatar(child: Text(username[0].toUpperCase()))),
        Expanded(child: Text(username, textAlign: TextAlign.center)),
      ],
    );
  }
}
