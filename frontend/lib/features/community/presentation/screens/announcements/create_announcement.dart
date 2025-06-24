import 'package:flutter/material.dart';
import 'package:frontend/shared/widgets/primary_button.dart';
import 'package:frontend/shared/widgets/alt_button.dart';

class CreateAnnouncementScreen extends StatefulWidget {
  const CreateAnnouncementScreen({super.key});

  @override
  State<CreateAnnouncementScreen> createState() => _CreateAnnouncementScreenState();
}

class _CreateAnnouncementScreenState extends State<CreateAnnouncementScreen> {
  final TextEditingController _messageController = TextEditingController();

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
                    const SizedBox(height: 20),
                    TextField(
                      controller: _messageController,
                      maxLines: null,
                      minLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Anuncio',
                        hintText: 'Escribe el anuncio...',
                        labelStyle: TextStyle(fontSize: 20, color: Colors.black87),
                        hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
                        alignLabelWithHint: true,
                        border: UnderlineInputBorder(),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 24),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFFB0C8FF),
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add, color: Color(0xFF5988FF), size: 24),
                              SizedBox(height: 4),
                              Text(
                                'Agrega una imagen',
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Etiqueta',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 16),
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
                    onPressed: () {
                      Navigator.pop(context);
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
          ],
        ),
      ),
    );
  }
}
