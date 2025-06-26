import 'package:flutter/material.dart';
import 'package:frontend/features/community/presentation/widgets/announcements/announcements_box.dart';
import 'package:frontend/shared/widgets/alt_button.dart';
import 'package:frontend/shared/widgets/primary_button.dart';

class AnnouncementAdminScreen extends StatefulWidget {
  const AnnouncementAdminScreen({super.key});

  @override
  State<AnnouncementAdminScreen> createState() => _AnnouncementAdminScreenState();
}

class _AnnouncementAdminScreenState extends State<AnnouncementAdminScreen> {
  final bool _isLoading = false;

  final List<Map<String, dynamic>> _fakeAnnouncements = [
    {
      'userName': 'Juan Perez',
      'time': '· 00h',
      'message': 'Lorem ipsum dolor sit amet. Quo tempora aliquid ea quos aliquam...',
      'tag': 'Reunion',
      'imageUrl': null,
      'likes': 11,
    },
    {
      'userName': 'Ana Gomez',
      'time': '· 00h',
      'message': 'Lorem ipsum dolor sit amet. Quo tempora aliquid ea quos aliquam...',
      'tag': 'Emergencia',
      'imageUrl': 'https://via.placeholder.com/300x150',
      'likes': 11,
    },
    {
      'userName': 'Martin Zuñiga',
      'time': '· 00h',
      'message': 'Lorem ipsum dolor sit amet. Quo tempora aliquid ea quos aliquam...',
      'tag': 'Anuncio',
      'imageUrl': null,
      'likes': 5,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Text(
                          'Anuncios',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                        ),
                        const SizedBox(height: 8),
                        const Divider(
                          color: Color(0xFF5988FF),
                          thickness: 3,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: ListView.builder(
                        itemCount: _fakeAnnouncements.length,
                        itemBuilder: (context, index) {
                          final a = _fakeAnnouncements[index];
                          return AnnouncementBox(
                            username: a['userName'],
                            time: a['time'],
                            message: a['message'],
                            tag: a['tag'],
                            imageUrl: a['imageUrl'],
                            likes: a['likes'],
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        PrimaryButton(
                          label: 'Crear Anuncio',
                          onPressed: () {
                            Navigator.of(context).pushNamed('/home/admin/announcements/create');
                          },
                          width: double.infinity,
                        ),
                        const SizedBox(height: 10),
                        AltButton(
                          label: 'Volver',
                          onPressed: () {
                            Navigator.of(context).pop();
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
