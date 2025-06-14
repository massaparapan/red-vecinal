import 'package:flutter/material.dart';
import 'package:frontend/features/profile/models/otherprofileDto.dart';
import 'package:frontend/features/user/services/user_service.dart';
import 'package:frontend/shared/widgets/alt_button.dart';

class OtherPersonProfileScreen extends StatefulWidget {
  final int userId;

  const OtherPersonProfileScreen({super.key, required this.userId});

  @override
  State<OtherPersonProfileScreen> createState() => _OtherPersonProfileScreenState();
}

class _OtherPersonProfileScreenState extends State<OtherPersonProfileScreen> {
  final _userService = UserService.withDefaults();
  late OtherProfileDto user;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Future<void> _fetchUserProfile() async {
    try {
      final result = await _userService.getUserProfile(widget.userId);
      setState(() {
        user = result;
        _isLoading = false;
      });
    } catch (e) {
      print("Error al obtener el perfil: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(24.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      Text(
                        'Perfil',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Divider(
                        color: const Color(0xFF5988FF),
                        thickness: 3,
                        height: 1,
                        indent: 3,
                      ),
                      const SizedBox(height: 20),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blue[100],
                        child: Text(
                          user.username.isNotEmpty ? user.username[0].toUpperCase() : '?',
                          style: const TextStyle(fontSize: 40, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 10),
                      _readOnlyField("Nombre", user.username),
                      _readOnlyField("Descripción", user.description),
                      _readOnlyField("Junta de vecinos", user.nameOfCommunity),
                      const SizedBox(height: 20),
                      AltButton(
                        label: 'Volver',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        width: double.infinity,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  Widget _readOnlyField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        const SizedBox(height: 6),
        TextFormField(
          initialValue: value,
          readOnly: true,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
