import 'package:flutter/material.dart';
import 'package:frontend/screens/auth/auth_page.dart';
import 'package:frontend/screens/no_community_screen/no_community_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Red Vecinal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 255, 255, 255)),
      ),
      home: const AuthPage(),
    );
  }
}