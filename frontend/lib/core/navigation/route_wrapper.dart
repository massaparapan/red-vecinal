import 'package:go_router/go_router.dart';

class AppRoute extends GoRoute {
  AppRoute({
    required super.path,
    required String name,
    super.builder,
    super.pageBuilder,
    super.parentNavigatorKey,
    super.redirect,
    super.onExit,
    super.routes,
    this.isPublic = false,
    this.requiresAuth = false,
  }) : assert(_isValidPath(path)),
       super(name: name);

  static bool _isValidPath(String path) {
    return RegExp(r'^[a-z:/-]+$').hasMatch(path);
  }

  final bool isPublic;
  final bool requiresAuth;
}
