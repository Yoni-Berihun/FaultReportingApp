import 'fixer_connectivity_coordinator.dart';
import 'fixer_mode_service.dart';
import 'fixer_realtime_bridge.dart';
import 'fixer_sync_service.dart';

/// Coordinates connectivity + Realtime when fixer mode is enabled.
class FixerBootstrap {
  FixerBootstrap._();

  static final FixerConnectivityCoordinator connectivity =
      FixerConnectivityCoordinator();
  static final FixerRealtimeBridge realtime = FixerRealtimeBridge();

  static Future<void> syncIfEnabled() async {
    if (await FixerModeService.isEnabled()) {
      connectivity.start();
      realtime.start();
      await FixerSyncService.instance.fullSync();
    } else {
      connectivity.stop();
      realtime.stop();
    }
  }
}
