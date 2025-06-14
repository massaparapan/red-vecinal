import 'package:flutter/material.dart';
import 'package:frontend/features/join-request/presentation/widgets/join_request_tile.dart';
import 'package:frontend/features/community/services/community_service.dart';
import 'package:frontend/features/join-request/models/request/membership_request.dart';
import 'package:frontend/features/membership/services/membership_service.dart';
import 'package:frontend/shared/widgets/primary_button.dart';

class JoinRequestsScreen extends StatefulWidget {
  const JoinRequestsScreen({super.key});

  @override
  State<JoinRequestsScreen> createState() => _JoinRequestsScreenState();
}

class _JoinRequestsScreenState extends State<JoinRequestsScreen> {
  late Future<List<MembershipRequest>> _pendingRequestsFuture;
  final communityService = CommunityService.withDefaults();
  final membershipService = MembershipService.withDefaults();

  @override
  void initState() {
    super.initState();
    _pendingRequestsFuture = _loadRequests();
  }

  Future<List<MembershipRequest>> _loadRequests() async {
    final all = await membershipService.getMyCommunityMemberships();
    return all.where((r) => r.status == "PENDING").toList();
  }

  void _handleAccept(int membershipId) async {
    await membershipService.acceptMembership(membershipId);
    setState(() {
      _pendingRequestsFuture = _loadRequests();
    });
  }

  void _handleReject(int membershipId) async {
    await membershipService.rejectMembership(membershipId);
    setState(() {
      _pendingRequestsFuture = _loadRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<MembershipRequest>>(
          future: _pendingRequestsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            final requests = snapshot.data!;
            if (requests.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "No hay solicitudes pendientes",
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 50),
                    PrimaryButton(
                      label: "Volver",
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              );
            }

            return ListView(
              padding: const EdgeInsets.all(24),
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Text(
                    'Solicitudes',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(
                  color: Color(0xFF5988FF),
                  thickness: 3,
                  height: 1,
                  indent: 3,
                ),
                const SizedBox(height: 16),
                ...requests.map((request) {
                  final user = request.userDto;
                  return JoinRequestTile(
                    username: user.username,
                    imageUrl: user.imageProfileUrl ?? '',
                    onAccept: () => _handleAccept(request.id),
                    onReject: () => _handleReject(request.id),
                  );
                }).toList(),
              ],
            );
          },
        ),
      ),
    );
  }
}
