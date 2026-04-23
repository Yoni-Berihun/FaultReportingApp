import 'package:flutter/foundation.dart';

/// Supabase and feature flags. Prefer passing via `--dart-define` in CI/release.
@immutable
class AppConfig {
  const AppConfig({
    required this.supabaseUrl,
    required this.supabaseAnonKey,
    required this.faultReportsBucket,
    this.fixerStorageSignedUrlSeconds = 3600,
  });

  final String supabaseUrl;
  final String supabaseAnonKey;
  final String faultReportsBucket;
  final int fixerStorageSignedUrlSeconds;

  static const String _defaultUrl = 'https://hmfmeayfrgniwkiraybh.supabase.co';
  static const String _defaultKey =
      'sb_publishable_bVdZvmSmoCcaiI974DocWg_NvN0sFwm';

  static const AppConfig instance = AppConfig(
    supabaseUrl: String.fromEnvironment(
      'SUPABASE_URL',
      defaultValue: _defaultUrl,
    ),
    supabaseAnonKey: String.fromEnvironment(
      'SUPABASE_ANON_KEY',
      defaultValue: _defaultKey,
    ),
    faultReportsBucket: String.fromEnvironment(
      'FAULT_REPORTS_BUCKET',
      defaultValue: 'fault-reports',
    ),
  );
}

/// Dev-only: change in source to enable the fixer password gate. Not user-facing.
const String kFixerEnablePasscode = '000000';
