class AppRoutes {
  static const String home = '/';
  static const String auth = '/auth';
  static const String profile = '/profile';

  static const String adminHome = '/home/admin';
  static const String memberHome = '/home/member';
  static const String noCommunityHome = '/home/no-community';
  static const String communityRequests = '/home/admin/community-requests';


  static String getRouteByRole(String? status, String? role) {
    if (status == null || status.isEmpty) return AppRoutes.noCommunityHome;
    if (role == "ADMIN") return adminHome;
    return memberHome;
  }
}
