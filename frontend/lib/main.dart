import 'package:flutter/material.dart';
import 'package:frontend/core/navigation/app_routes.dart';
import 'package:frontend/core/navigation/navegation_service.dart';
import 'package:frontend/features/auth/presentation/screens/auth_page.dart';
import 'package:frontend/features/community/presentation/screens/nearby_communities_map.dart';
import 'package:frontend/features/events/presentation/screens/createEvent.dart';
import 'package:frontend/features/events/presentation/screens/eventsAdmin.dart';
import 'package:frontend/features/announcements/presentation/screens/announcements.dart';
import 'package:frontend/features/announcements/presentation/screens/announcements_admin.dart';
import 'package:frontend/features/announcements/presentation/screens/create_announcement.dart';
import 'package:frontend/features/information/presentation/screens/information.dart';
import 'package:frontend/features/information/presentation/screens/informationMember.dart';
import 'package:frontend/features/events/presentation/screens/reminder_screen.dart';
import 'package:frontend/features/join-request/presentation/screens/requests.dart';
import 'package:frontend/features/membership/presentation/screens/members_screen.dart';
import 'package:frontend/shared/menu_screen/admin_home.dart';
import 'package:frontend/shared/menu_screen/member_home.dart';
import 'package:frontend/shared/menu_screen/no_community_home.dart';
import 'package:frontend/features/profile/presentation/screens/profile.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
        primaryColor: const Color(0xFF5988FF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 255, 255, 255),
          primary: const Color(0xFF5988FF),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          floatingLabelStyle: TextStyle(
            color: Color.fromARGB(255, 161, 161, 161),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 156, 156, 156)),
          ),
        )
      ),
      locale: const Locale('es', 'ES'),
      supportedLocales: const [
        Locale('es', 'ES'), 
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      navigatorKey: NavegationService().navigatorKey,

      initialRoute: AppRoutes.auth,

      routes: {
        AppRoutes.auth: (context) => const AuthPage(),

        AppRoutes.adminHome: (context) => const AdminHomeScreen(),
        AppRoutes.memberHome: (context) => const MemberHomeScreen(),
        AppRoutes.noCommunityHome: (context) => const NoCommunityScreen(),
        AppRoutes.profile: (context) => const ProfileScreen(),
        AppRoutes.communityRequests: (context) => const JoinRequestsScreen(),
        AppRoutes.adminEventsScreen: (context) => const EventsAdminScreen(),
        AppRoutes.communityMembers: (context) => const MembershipScreen(),
        AppRoutes.createEventScreen: (context) => const CreateEventScreen(),
        AppRoutes.announcements: (context) => const AnnouncementsScreen(),
        AppRoutes.announcementsAdmin: (context) => const AnnouncementAdminScreen(),
        AppRoutes.createAnnouncementScreen: (context) => const CreateAnnouncementScreen(),
        AppRoutes.informationScreen: (context) => const InformationScreen(),
        AppRoutes.informationMemberScreen: (context) => const InformationMemberScreen(),
        AppRoutes.reminderScreen: (context) => const ReminderScreen(),
        AppRoutes.map: (context) => const NearbyCommunitiesMap(),
      },
    );
  }
}
