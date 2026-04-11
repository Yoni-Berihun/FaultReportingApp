import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'screens/home_screen.dart';
import 'screens/map_preview_screen.dart';
import 'screens/confirmation_screen.dart';
import 'screens/permissions_onboarding_screen.dart';
import 'models/fault_report.dart';
import 'services/permission_service.dart';

late final String _initialRoute;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://hmfmeayfrgniwkiraybh.supabase.co',
    anonKey: 'sb_publishable_bVdZvmSmoCcaiI974DocWg_NvN0sFwm',
  );
  final shouldShowOnboarding = await PermissionService.shouldShowOnboarding();
  _initialRoute = shouldShowOnboarding ? '/permissions' : '/';
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
  ],
);
