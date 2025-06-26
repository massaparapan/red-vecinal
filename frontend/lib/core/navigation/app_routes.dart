class AppRoutes {
  static const String home = '/';
  static const String auth = '/auth';
  static const String profile = '/profile';

  static const String adminHome = '/home/admin';
  static const String memberHome = '/home/member';
  static const String noCommunityHome = '/home/no-community';
  static const String communityRequests = '/home/admin/community-requests';
  static const String adminEventsScreen = '/home/admin/events';
  static const String createEventScreen = '/home/admin/events/create';
  static const String announcements = '/home/announcements';
  static const String announcementsAdmin = '/home/admin/announcements';
  static const String createAnnouncementScreen = '/home/admin/announcements/create';

  static String getRouteByRole(String? status, String? role) {
    if (status == null || status.isEmpty) return AppRoutes.noCommunityHome;
    if (role == "ADMIN") return adminHome;
    return memberHome;
  }
}
