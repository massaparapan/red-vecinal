import 'package:flutter/material.dart';
import 'package:frontend/features/announcements/models/response/announcement_response.dart';
import 'package:frontend/features/announcements/services/announcements_service.dart';
import 'package:frontend/features/announcements/presentation/widgets/announcements_box.dart';
import 'package:frontend/shared/widgets/alt_button.dart';
import 'package:frontend/shared/widgets/primary_button.dart';

class AnnouncementAdminScreen extends StatefulWidget {
  const AnnouncementAdminScreen({super.key});

  @override
  State<AnnouncementAdminScreen> createState() => _AnnouncementAdminScreenState();
}

class _AnnouncementAdminScreenState extends State<AnnouncementAdminScreen> {
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
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
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
