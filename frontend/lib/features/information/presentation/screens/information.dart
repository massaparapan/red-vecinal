import 'package:flutter/material.dart';
import 'package:frontend/features/information/models/response/information_response_dto.dart';
import 'package:frontend/features/information/presentation/screens/information_creation.dart';
import 'package:frontend/features/information/presentation/screens/information_view.dart';
import 'package:frontend/features/information/presentation/widgets/information_box.dart';
import 'package:frontend/features/information/services/information_service.dart';
import 'package:frontend/shared/widgets/primary_button.dart';
import 'package:frontend/shared/widgets/alt_button.dart';

class InformationScreen extends StatefulWidget {
  const InformationScreen({super.key});

  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  final informationService = InformationService.withDefaults();
  List<InformationResponseDto> _infoList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchInformation();
  }

  Future<void> _fetchInformation() async {
    setState(() => _isLoading = true);
    try {
      final data = await informationService.getMyCommunityInformations();
      setState(() => _infoList = data);
    } catch (e) {
      print('Error fetching info: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _goToDetail(InformationResponseDto info) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ViewInformationScreen(
          id: info.id,
          title: info.title,
          content: info.content,
        ),
      ),
    );
    if (result == true) {
      _fetchInformation(); // Recargar si se eliminó
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
              ),
              const SizedBox(height: 20),
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _infoList.isEmpty
                        ? const Center(
                            child: Text(
                              "No hay informaciones en esta comunidad.",
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            itemCount: _infoList.length,
                            itemBuilder: (context, index) {
                              final info = _infoList[index];
                              return InformationBox(
                                title: info.title,
                                content: info.content,
                                onTap: () => _goToDetail(info),
                              );
                            },
                          ),
              ),
              PrimaryButton(
                label: "Agregar información",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const CreateInformationScreen(),
                    ),
                  ).then((_) => _fetchInformation());
                },
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
