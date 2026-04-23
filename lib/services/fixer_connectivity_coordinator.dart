import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'fixer_sync_service.dart';

/// Listens to connectivity; drives offline mark + resync.
class FixerConnectivityCoordinator {
  StreamSubscription<List<ConnectivityResult>>? _sub;

  void start() {
    _sub?.cancel();
    _sub = Connectivity().onConnectivityChanged.listen(
      (List<ConnectivityResult> results) {
        final online = results.any((r) => r != ConnectivityResult.none);
        if (!online) {
          FixerSyncService.instance.onBecameOffline();
        } else {
          FixerSyncService.onRegainedNetwork();
        }
      },
    );
  }

  void stop() {
    _sub?.cancel();
    _sub = null;
  }
}
