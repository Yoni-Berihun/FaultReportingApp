import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:workmanager/workmanager.dart';

import '../core/app_config.dart';
import 'fixer_mode_service.dart';
import 'fixer_sync_service.dart';

const String kFixerWorkUniqueName = 'fixerSyncWork';
const String kFixerTaskName = 'com.hawassa.fault_reporting.fixerSync';

@pragma('vm:entry-point')
void fixerWorkmanagerCallbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();
    if (Platform.isAndroid) {
      try {
        await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      } catch (_) {
        // Best-effort: continue even if the workaround is unnecessary.
      }
    }
    if (!await FixerModeService.isEnabled()) {
      return true;
    }
    const c = AppConfig.instance;
    await Supabase.initialize(url: c.supabaseUrl, anonKey: c.supabaseAnonKey);
    await FixerSyncService.instance.fullSync();
    return true;
  });
}

class BackgroundWorkManager {
  const BackgroundWorkManager._();

  static Future<void> registerIfFixer() async {
    if (!Platform.isAndroid) {
      return;
    }
    if (!await FixerModeService.isEnabled()) {
      return;
    }
    if (kIsWeb) {
      return;
    }
    try {
      await Workmanager().initialize(
        fixerWorkmanagerCallbackDispatcher,
        isInDebugMode: kDebugMode,
      );
      await Workmanager().registerPeriodicTask(
        kFixerWorkUniqueName,
        kFixerTaskName,
        frequency: const Duration(hours: 1),
        existingWorkPolicy: ExistingWorkPolicy.replace,
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
      );
    } catch (_) {
      // Registration can fail in emulators; ignore for smoke runs.
    }
  }

  static Future<void> cancel() async {
    if (!Platform.isAndroid) {
      return;
    }
    try {
      await Workmanager().cancelByUniqueName(kFixerWorkUniqueName);
    } catch (_) {}
  }
}
