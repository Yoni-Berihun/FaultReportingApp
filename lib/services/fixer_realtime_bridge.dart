import 'package:supabase_flutter/supabase_flutter.dart';

import 'fixer_sync_service.dart';

/// Pushes new/updated `reports` rows from Supabase into the local cache.
class FixerRealtimeBridge {
  RealtimeChannel? _channel;

  void start() {
    if (_channel != null) {
      return;
    }
    final supabase = Supabase.instance.client;
    _channel = supabase.channel('public:reports_inbox');
    _channel!
      ..onPostgresChanges(
        event: PostgresChangeEvent.insert,
        schema: 'public',
        table: 'reports',
        callback: (payload) async {
          final row = _mapRecord(payload.newRecord);
          if (row == null) {
            return;
          }
          await FixerSyncService.instance.upsertRemoteRow(row, source: 'realtime');
        },
      )
      ..onPostgresChanges(
        event: PostgresChangeEvent.update,
        schema: 'public',
        table: 'reports',
        callback: (payload) async {
          final row = _mapRecord(payload.newRecord);
          if (row == null) {
            return;
          }
          await FixerSyncService.instance.upsertRemoteRow(row, source: 'realtime');
        },
      )
      ..subscribe();
  }

  void stop() {
    _channel?.unsubscribe();
    _channel = null;
  }

  Map<String, dynamic>? _mapRecord(Map<String, dynamic>? raw) {
    if (raw == null) {
      return null;
    }
    return Map<String, dynamic>.from(raw);
  }
}
