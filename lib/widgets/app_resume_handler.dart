import 'package:flutter/material.dart';

import '../services/fixer_mode_service.dart';
import '../services/fixer_sync_service.dart';

/// Triggers a catch-up sync when the app comes back to the foreground
/// and fixer mode is enabled.
class AppResumeHandler extends StatefulWidget {
  const AppResumeHandler({super.key, required this.child});
  final Widget child;

  @override
  State<AppResumeHandler> createState() => _AppResumeHandlerState();
}

class _AppResumeHandlerState extends State<AppResumeHandler>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      FixerModeService.isEnabled().then((f) {
        if (f) {
          return FixerSyncService.onRegainedNetwork();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
