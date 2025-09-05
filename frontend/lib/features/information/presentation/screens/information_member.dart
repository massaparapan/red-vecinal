import 'package:flutter/material.dart';
import 'package:frontend/features/information/models/response/information_response.dart';
import 'package:frontend/features/information/presentation/widgets/information_box.dart';
import 'package:frontend/shared/widgets/alt_button.dart';
import 'package:frontend/features/information/services/information_service.dart';
import 'package:frontend/features/information/presentation/screens/information_view.dart';

class InformationMemberScreen extends StatefulWidget {
  const InformationMemberScreen({super.key});

  @override
  State<InformationMemberScreen> createState() => _InformationMemberScreenState();
}

class _InformationMemberScreenState extends State<InformationMemberScreen> {
  final informationService = InformationService.withDefaults();
  bool _isLoading = false;
  List<InformationResponse> informations = [];

  @override
  void initState() {
    super.initState();
    _fetchInformations();
  }

  Future<void> _fetchInformations() async {
    setState(() => _isLoading = true);
    try {
      final data = await informationService.getMyCommunityInformations();
      setState(() {
        informations = data;
      });
    } catch (e) {
      print('Error fetching information: $e');
    } finally {
      setState(() => _isLoading = false);
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
                'Información de la comunidad',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Divider(
                color: Color(0xFF5988FF),
                thickness: 3,
                height: 1,
                indent: 3,
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : informations.isEmpty
                        ? const Center(
                            child: Text(
                              "No hay informaciones en esta comunidad.",
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            itemCount: informations.length,
                            itemBuilder: (context, index) {
                              final info = informations[index];
                              return InformationBox(
                                title: info.title,
                                content: info.content,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ViewInformationScreen(
                                        title: info.title,
                                        content: info.content,
                                        id: info.id,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
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