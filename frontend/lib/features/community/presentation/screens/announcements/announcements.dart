import 'package:flutter/material.dart';
import 'package:frontend/features/community/presentation/widgets/announcements/announcements_box.dart';
import 'package:frontend/shared/widgets/primary_button.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});
  
  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
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
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          child: const Divider(
                            color: Color(0xFF5988FF),
                            thickness: 3,
                            height: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          ..._fakeAnnouncements.map((a) {
                            return AnnouncementBox(
                              username: a['userName'],
                              time: a['time'],
                              message: a['message'],
                              tag: a['tag'],
                              imageUrl: a['imageUrl'],
                              likes: a['likes'],
                            );
                          }),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: PrimaryButton(
          label: 'Volver',
          onPressed: () {
            Navigator.of(context).pop();
          },
          width: double.infinity,
        ),
      ),
    );
  }
}
