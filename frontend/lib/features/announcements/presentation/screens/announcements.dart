import 'package:flutter/material.dart';
import 'package:frontend/features/announcements/models/response/announcementResponseDto.dart';
import 'package:frontend/features/announcements/services/announcements_service.dart';
import 'package:frontend/features/announcements/presentation/widgets/announcements_box.dart';
import 'package:frontend/shared/widgets/primary_button.dart';

class AnnouncementsScreen extends StatefulWidget {
  const AnnouncementsScreen({super.key});

  @override
  State<AnnouncementsScreen> createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  final announcementsService = AnnouncementsService.withDefaults();
  bool _isLoading = false;
  List<AnnouncementResponse> _announcements = [];

  @override
  void initState() {
    super.initState();
    _fetchAnnouncements();
  }

  Future<void> _fetchAnnouncements() async {
    setState(() => _isLoading = true);
    try {
      final data = await announcementsService.getAnnouncementsByMyCommunity();
      data.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      setState(() {
        _announcements = data;
      });
    } catch (e) {
      print('Error fetching announcements: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  String _formatTime(DateTime utcTime) {
    final dt = utcTime.subtract(const Duration(hours: -4));
    final now = DateTime.now();
    final diff = now.difference(dt);

    if (diff.inMinutes < 1) return 'ahora';
    if (diff.inHours < 1) return '${diff.inMinutes}m';
    if (diff.inDays < 1) return '${diff.inHours}h';
    return '${diff.inDays}d';
  }

  String _mapTagLabel(String type) {
    switch (type) {
      case 'EMERGENCY':
        return 'Emergencia';
      case 'ANNOUNCEMENT':
        return 'Anuncio';
      case 'MEETING':
        return 'Reunión';
      default:
        return type;
    }
  }

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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: ListView.builder(
                        itemCount: _announcements.length,
                        itemBuilder: (context, index) {
                          final a = _announcements[index];
                          return AnnouncementBox(
                            username: a.createdBy.username,
                            time: '· ${_formatTime(a.createdAt)}',
                            message: a.content,
                            tag: _mapTagLabel(a.type),
                          );
                        },
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
