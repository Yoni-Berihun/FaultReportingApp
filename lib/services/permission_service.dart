import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PermissionService {
  static const String firstLaunchKey = 'permissions_requested_first_launch';

  static Future<bool> shouldShowOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return !(prefs.getBool(firstLaunchKey) ?? false);
  }

  static Future<Map<Permission, PermissionStatus>> requestCorePermissions() {
    final permissions = <Permission>[
      Permission.locationWhenInUse,
      Permission.camera,
      Permission.photos,
      if (Platform.isAndroid) Permission.storage,
    ];

    return permissions.request();
  }

  static Future<void> markOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(firstLaunchKey, true);
  }
}
