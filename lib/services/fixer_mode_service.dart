import 'package:shared_preferences/shared_preferences.dart';

/// On-device only: enables the fixer screen and background sync. Set to true
/// on the single maintenance device (Settings screen or after passcode).
class FixerModeService {
  static const _prefKey = 'fixer_mode_enabled_v1';

  static Future<bool> isEnabled() async {
    final p = await SharedPreferences.getInstance();
    return p.getBool(_prefKey) ?? false;
  }

  static Future<void> setEnabled(bool value) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(_prefKey, value);
  }
}
