import 'package:flutter/material.dart';
import 'package:frontend/features/community/presentation/widgets/information_box.dart';
import 'package:frontend/shared/widgets/alt_button.dart';

class InformationMemberScreen extends StatefulWidget {
  const InformationMemberScreen({super.key});

  @override
  State<InformationMemberScreen> createState() => _InformationMemberScreenState();
}

class _InformationMemberScreenState extends State<InformationMemberScreen> {
  List<String> infoTitles = []; 

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        infoTitles = [
          "Información 1",
          "Información 2",
          "Información 3",
          "Información 4",
          "Información 5",
          "Información 6",
          "Información 7",
          "Información 8",
          "Información 9",
          "Información 10",
        ];
      });
    });
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
                child: infoTitles.isEmpty
                    ? const Center(
                        child: Text(
                          "No hay informaciones en esta comunidad.",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: infoTitles.length,
                        itemBuilder: (context, index) {
                          return InformationBox(
                            title: infoTitles[index],
                            onTap: () {
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
