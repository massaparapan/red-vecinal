import 'package:flutter/material.dart';
import 'package:frontend/features/user/services/user_service.dart';
import 'package:frontend/shared/widgets/primary_button.dart';
import 'package:frontend/shared/widgets/alt_button.dart';

class CreateInformationScreen extends StatefulWidget {
  const CreateInformationScreen({super.key});

  @override
  State<CreateInformationScreen> createState() => _CreateInformationScreenState();
}

class _CreateInformationScreenState extends State<CreateInformationScreen> {
  final userService = UserService.withDefaults();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  bool _showSaveButton = false;

  @override
  void initState() {
    super.initState();
    _titleController.addListener(_checkChanges);
    _contentController.addListener(_checkChanges);
  }

  void _checkChanges() {
    setState(() {
      _showSaveButton =
          _titleController.text.trim().isNotEmpty && _contentController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
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
              TextField(
                controller: _titleController,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                  hintText: 'Escribe el título de la información',
                  border: InputBorder.none,
                ),
              ),
              const Divider(
                color: Color(0xFF5988FF),
                thickness: 3,
                height: 1,
                indent: 3,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: TextField(
                  controller: _contentController,
                  maxLines: null,
                  expands: true,
                  decoration: const InputDecoration(
                    hintText: 'Escriba la información',
                    border: InputBorder.none,
                    alignLabelWithHint: true,
                  ),
                  style: const TextStyle(fontSize: 22, height: 1.5),
                ),
              ),
              if (_showSaveButton)
                PrimaryButton(
                  label: "Guardar cambios",
                  onPressed: () {
                  },
                  width: double.infinity,
                ),
              const SizedBox(height: 10),
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
    );
  }
}
