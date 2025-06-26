import 'package:flutter/material.dart';
import 'package:frontend/features/information/services/information_service.dart';
import 'package:frontend/features/membership/services/membership_service.dart';
import 'package:frontend/shared/widgets/alt_button.dart';
import 'package:frontend/shared/widgets/primary_button.dart';

class ViewInformationScreen extends StatefulWidget {
  final int id;
  final String title;
  final String content;

  const ViewInformationScreen({
    super.key,
    required this.id,
    required this.title,
    required this.content,
  });

  @override
  State<ViewInformationScreen> createState() => _ViewInformationScreenState();
}

class _ViewInformationScreenState extends State<ViewInformationScreen> {
  final informationService = InformationService.withDefaults();
  final membershipService = MembershipService.withDefaults();
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    _checkIfAdmin();
  }

  Future<void> _checkIfAdmin() async {
    try {
      final membership = await membershipService.getMyMembership();
      setState(() {
        isAdmin = membership.role == "ADMIN";
      });
    } catch (e) {
      print("Error checking admin: $e");
    }
  }

  Future<void> _deleteInformation() async {
    try {
      await informationService.deleteInformation(widget.id);
      if (context.mounted) Navigator.pop(context, true);
    } catch (e) {
      print("Error deleting info: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const Divider(
                color: Color(0xFF5988FF),
                thickness: 3,
                height: 1,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    widget.content,
                    style: const TextStyle(fontSize: 22, height: 1.5),
                  ),
                ),
              ),
              if (isAdmin)
                PrimaryButton(
                  label: "Eliminar",
                  onPressed: _deleteInformation,
                  width: double.infinity,
                ),
              const SizedBox(height: 10),
              AltButton(
                label: 'Volver',
                onPressed: () => Navigator.pop(context),
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
