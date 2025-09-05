import 'package:flutter/material.dart';
import 'package:frontend/features/announcements/models/request/create_announcement_request.dart';
import 'package:frontend/features/announcements/services/announcements_service.dart';
import 'package:frontend/shared/widgets/primary_button.dart';
import 'package:frontend/shared/widgets/alt_button.dart';

class CreateAnnouncementScreen extends StatefulWidget {
  const CreateAnnouncementScreen({super.key});

  @override
  State<CreateAnnouncementScreen> createState() => _CreateAnnouncementScreenState();
}

class _CreateAnnouncementScreenState extends State<CreateAnnouncementScreen> {
  final TextEditingController _messageController = TextEditingController();
  final announcementsService = AnnouncementsService.withDefaults();

  String selectedTag = 'ANNOUNCEMENT';

  void _showTagSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Selecciona una etiqueta',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: const Text('Anuncio'),
              onTap: () {
                setState(() {
                  selectedTag = 'ANNOUNCEMENT';
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Emergencia'),
              onTap: () {
                setState(() {
                  selectedTag = 'EMERGENCY';
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Reunión'),
              onTap: () {
                setState(() {
                  selectedTag = 'MEETING';
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _createAnnouncement() async {
    final dto = CreateAnnouncementRequest(
      content: _messageController.text.trim(),
      type: selectedTag,
    );

    try {
      await announcementsService.createAnnouncement(dto);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Anuncio creado exitosamente")),
      );
      Navigator.pop(context);
    } catch (e) {
      print("Error al crear anuncio: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error al crear el anuncio")),
      );
    }
  }

  String _tagLabel(String tagValue) {
    switch (tagValue) {
      case 'ANNOUNCEMENT':
        return 'Anuncio';
      case 'EMERGENCY':
        return 'Emergencia';
      case 'MEETING':
        return 'Reunión';
      default:
        return tagValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 5),
                    Text(
                      'Crear anuncio',
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    const Divider(
                      color: Color(0xFF5988FF),
                      thickness: 2,
                    ),
                    const SizedBox(height: 24),
                    TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        labelText: 'Contenido',
                        hintText: 'Escribe el anuncio...',
                        labelStyle: TextStyle(fontSize: 20, color: Colors.black87),
                        border: UnderlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Etiqueta',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: GestureDetector(
                            onTap: _showTagSelector,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _tagLabel(selectedTag),
                                    style: const TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  PrimaryButton(
                    label: "Crear",
                    onPressed: _createAnnouncement,
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
          ],
        ),
      ),
    );
  }
}
