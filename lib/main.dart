import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/app_config.dart';
import 'models/fault_report.dart';
import 'screens/confirmation_screen.dart';
import 'screens/fixer/fixer_mode_gate_screen.dart';
import 'screens/fixer/fixer_report_detail_screen.dart';
import 'screens/fixer/fixer_reports_list_screen.dart';
import 'screens/home_screen.dart';
import 'screens/map_preview_screen.dart';
import 'screens/permissions_onboarding_screen.dart';
import 'services/background_work_manager.dart';
import 'services/fixer_bootstrap.dart';
import 'services/local_notification_service.dart';
import 'services/permission_service.dart';
import 'widgets/app_resume_handler.dart';

// Default for tests / when `main()` is not executed (e.g. widget_test).
String _initialRoute = '/';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    try {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    } catch (_) {}
  }

  const config = AppConfig.instance;
  await Supabase.initialize(
    url: config.supabaseUrl,
    anonKey: config.supabaseAnonKey,
  );
  await LocalNotificationService.instance.init();
  final shouldShowOnboarding = await PermissionService.shouldShowOnboarding();
  _initialRoute = shouldShowOnboarding ? '/permissions' : '/';
  await FixerBootstrap.syncIfEnabled();
  await BackgroundWorkManager.registerIfFixer();
  runApp(const FaultReportingApp());
}

class FaultReportingApp extends StatelessWidget {
  const FaultReportingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fault Reporting',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0085D5),
          primary: const Color(0xFF0085D5),
        ),
        useMaterial3: true,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF0085D5), width: 2),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF0085D5),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 54),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            textStyle:
                const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            elevation: 2,
          ),
        ),
      ),
      routerConfig: _router,
      builder: (context, child) {
        if (kIsWeb) {
          return child ?? const SizedBox.shrink();
        }
        return AppResumeHandler(child: child ?? const SizedBox.shrink());
      },
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: _initialRoute,
  routes: [
    GoRoute(
      path: '/permissions',
      builder: (context, state) => const PermissionsOnboardingScreen(),
    ),
    GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: '/map-preview',
      builder: (context, state) =>
          MapPreviewScreen(report: state.extra as FaultReport),
    ),
    GoRoute(
      path: '/confirmation',
      builder: (context, state) =>
          ConfirmationScreen(trackingId: state.extra as String? ?? ''),
    ),
    GoRoute(
      path: '/fixer/gate',
      builder: (context, state) => const FixerModeGateScreen(),
    ),
    GoRoute(
      path: '/fixer/reports',
      builder: (context, state) => const FixerReportsListScreen(),
    ),
    GoRoute(
      path: '/fixer/reports/:id',
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return FixerReportDetailScreen(serverId: id);
      },
    ),
  ],
);
