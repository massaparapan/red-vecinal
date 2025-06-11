import 'package:flutter/material.dart';
import 'package:frontend/core/navigation/app_routes.dart';
import 'package:frontend/core/navigation/navegation_service.dart';
import 'package:frontend/features/auth/presentation/screens/auth_page.dart';
import 'package:frontend/features/membership/presentation/screens/community_members_screen.dart';
import 'package:frontend/shared/menu_screen/admin_home.dart';
import 'package:frontend/shared/menu_screen/no_community_home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 255, 255),
        ),
      ),
      navigatorKey: NavegationService().navigatorKey,

      initialRoute: AppRoutes.auth,

      routes: {
        AppRoutes.auth: (context) => const AuthPage(),

        AppRoutes.adminHome: (context) => const AdminHomeScreen(),
        AppRoutes.memberHome: (context) => const AdminHomeScreen(),
        AppRoutes.noCommunityHome: (context) => const NoCommunityScreen(),
        AppRoutes.communityMembers: (context) => const CommunityMembersScreen()
      },
    );
  }
}
