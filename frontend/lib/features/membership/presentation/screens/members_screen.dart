import 'package:flutter/material.dart';
import 'package:frontend/features/membership/models/response/community_member_response.dart';
import 'package:frontend/features/membership/repositories/membership_respository.dart';
import 'package:frontend/shared/widgets/primary_button.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  State<MembershipScreen> createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  late Future<List<CommunityMemberResponse>> _membersFuture;
  final membershipRepository = MembershipRepository();
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    _membersFuture = membershipRepository.getMembers();
    _checkAdminStatus();
  }

  void _checkAdminStatus() async {
    final membership = await membershipRepository.fetchMyMembership();
    setState(() {
      isAdmin = membership.role == "ADMIN";
    });
  }

  void _handleDeleteMember(int membershipId) async {
    try {
      await membershipRepository.deleteMember(membershipId);
      setState(() {
        _loadData();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Miembro eliminado exitosamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al eliminar miembro')),
      );
    }
  }

  void _showDeleteConfirmation(int membershipId, String username) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar eliminación'),
        content: Text('¿Estás seguro de que quieres eliminar a $username?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _handleDeleteMember(membershipId);
            },
            child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showMemberOptions(CommunityMemberResponse member) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              member.username,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            if (member.role != "ADMIN") ...[
              ListTile(
                leading: const Icon(Icons.admin_panel_settings, color: Colors.blue),
                title: const Text('Hacer Administrador'),
                onTap: () {
                  Navigator.of(context).pop();
                  _handleAssignAdmin(member.id);
                },
              ),
            ] else ...[
              ListTile(
                leading: const Icon(Icons.remove_moderator, color: Colors.orange),
                title: const Text('Quitar Roles'),
                onTap: () {
                  Navigator.of(context).pop();
                  _handleUnassignRoles(member.id);
                },
              ),
            ],
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text('Eliminar Miembro'),
              onTap: () {
                Navigator.of(context).pop();
                _showDeleteConfirmation(member.id, member.username);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _handleAssignAdmin(int membershipId) async {
    try {
      await membershipRepository.assignAdmin(membershipId);
      setState(() {
        _loadData();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Administrador asignado exitosamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  void _handleUnassignRoles(int membershipId) async {
    try {
      await membershipRepository.unassignRoles(membershipId);
      setState(() {
        _loadData();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Roles removidos exitosamente')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<List<CommunityMemberResponse>>(
          future: _membersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            }

            final members = snapshot.data!;
            if (members.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "No hay miembros en la comunidad",
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
                    'Miembros de la Comunidad',
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
                ...members.map((member) {
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: const Color(0xFF5988FF),
                        child: Text(
                          member.username[0].toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      title: Text(
                        member.username,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        'Rol: ${member.role}',
                        style: TextStyle(
                          color: member.role == "ADMIN" 
                              ? Colors.blue 
                              : Colors.grey[600],
                          fontWeight: member.role == "ADMIN" 
                              ? FontWeight.w500 
                              : FontWeight.normal,
                        ),
                      ),
                      trailing: isAdmin 
                          ? IconButton(
                              icon: const Icon(Icons.more_vert),
                              onPressed: () => _showMemberOptions(member),
                            )
                          : null,
                    ),
                  );
                })
              ],
            );
          },
        ),
      ),
    );
  }
}