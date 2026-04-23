import 'package:drift/drift.dart' show Value;
import 'package:fault_reporting_app/core/app_config.dart';
import 'package:fault_reporting_app/data/drift/app_database.dart';
import 'package:fault_reporting_app/services/fixer_mode_service.dart';
import 'package:fault_reporting_app/services/fixer_sync_policy.dart';
import 'package:fault_reporting_app/services/local_notification_service.dart';
import 'package:fault_reporting_app/supabase_service.dart';

const _kLastSyncKey = 'last_successful_sync_at';
const _kOfflineStartedKey = 'offline_started_at';

/// Remote fetch + local cache + reconnect notifications.
class FixerSyncService {
  FixerSyncService._();

  static final FixerSyncService instance = FixerSyncService._();

  final SupabaseService _remote = SupabaseService();
  final AppDatabase _db = AppDatabase.instance;

  static Future<void> onRegainedNetwork() async {
    if (!await FixerModeService.isEnabled()) {
      return;
    }
    await instance.fullSync();
  }

  Future<void> onBecameOffline() async {
    if (!await FixerModeService.isEnabled()) {
      return;
    }
    final existing = await _readKv(_kOfflineStartedKey);
    if (existing != null) {
      return;
    }
    await _writeKv(
      _kOfflineStartedKey,
      DateTime.now().toUtc().toIso8601String(),
    );
  }

  Future<void> fullSync() async {
    if (!await FixerModeService.isEnabled()) {
      return;
    }
    DateTime? since;
    final last = await _readKv(_kLastSyncKey);
    if (last != null) {
      since = DateTime.tryParse(last)?.toUtc();
    }

    await _remote.applyServerSideAutoResolve(days: 3);

    final rows = await _remote.fetchReports(sinceCreatedAt: since);
    for (final row in rows) {
      await upsertRemoteRow(row, source: 'sync');
    }

    await _maybeNotifyOfflineArrivals();

    await _writeKv(
      _kLastSyncKey,
      DateTime.now().toUtc().toIso8601String(),
    );
  }

  Future<void> upsertRemoteRow(
    Map<String, dynamic> row, {
    required String source,
  }) async {
    var companion = _companionFromRemote(row);
    final existing = await (_db.select(_db.localReports)
          ..where((t) => t.serverId.equals(companion.serverId.value)))
        .getSingleOrNull();
    if (existing != null) {
      companion = companion.copyWith(
        offlineNotified: Value(existing.offlineNotified),
      );
    }

    await _db.into(_db.localReports).insertOnConflictUpdate(companion);

    // Debug hook (avoid noisy logs in release).
    assert(() {
      // ignore: avoid_print
      print('[fixer] upsert from $source id=${row['id']}');
      return true;
    }());
  }

  LocalReportsCompanion _companionFromRemote(Map<String, dynamic> r) {
    final id = (r['id'] as num).toInt();
    return LocalReportsCompanion(
      serverId: Value(id),
      trackingId: Value((r['tracking_id'] as String?) ?? 'unknown'),
      createdAt: Value(_requireTs(r['created_at'])),
      description: Value((r['description'] as String?) ?? ''),
      contactNumber: Value((r['contact_number'] as String?) ?? ''),
      latitude: Value((r['latitude'] as num?)?.toDouble() ?? 0),
      longitude: Value((r['longitude'] as num?)?.toDouble() ?? 0),
      commonName: Value((r['common_name'] as String?) ?? ''),
      photoUrl: Value(r['photo_url'] as String?),
      photoStoragePath: Value(r['photo_storage_path'] as String?),
      status: Value((r['status'] as String?) ?? 'pending'),
      seenAt: Value(_optTs(r['seen_at'])),
      resolvedAt: Value(_optTs(r['resolved_at'])),
      photoDeletedAt: Value(_optTs(r['photo_deleted_at'])),
      lastSyncedAt: Value(DateTime.now().toUtc()),
      localActionState: const Value('synced'),
    );
  }

  DateTime _requireTs(Object? v) {
    if (v == null) {
      return DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
    }
    if (v is DateTime) {
      return v.toUtc();
    }
    return DateTime.parse(v as String).toUtc();
  }

  DateTime? _optTs(Object? v) {
    if (v == null) {
      return null;
    }
    if (v is DateTime) {
      return v.toUtc();
    }
    return DateTime.tryParse(v as String)?.toUtc();
  }

  Future<void> _maybeNotifyOfflineArrivals() async {
    final rawOffline = await _readKv(_kOfflineStartedKey);
    if (rawOffline == null) {
      return;
    }
    final offlineStart = DateTime.tryParse(rawOffline)?.toUtc();
    if (offlineStart == null) {
      await _writeKv(_kOfflineStartedKey, null);
      return;
    }

    final rows = await _db.select(_db.localReports).get();
    final pending = <LocalReport>[];
    for (final row in rows) {
      if (row.offlineNotified) {
        continue;
      }
      if (FixerSyncPolicy.isEligibleForOfflineNotification(
        reportCreatedAt: row.createdAt,
        offlineStartedAt: offlineStart,
      )) {
        pending.add(row);
      }
    }
    if (pending.isEmpty) {
      await _writeKv(_kOfflineStartedKey, null);
      return;
    }
    await LocalNotificationService.instance.showNewOfflineReports(pending.length);
    for (final p in pending) {
      await (_db.update(_db.localReports)..where((t) => t.serverId.equals(p.serverId)))
          .write(const LocalReportsCompanion(offlineNotified: Value(true)));
    }
    await _writeKv(_kOfflineStartedKey, null);
  }

  Future<void> markSeenFromFixer(int serverId) async {
    try {
      await _remote.markReportSeen(serverId);
    } catch (e) {
      await (_db.update(_db.localReports)
            ..where((t) => t.serverId.equals(serverId)))
          .write(
        const LocalReportsCompanion(localActionState: Value('failed_seen')),
      );
      rethrow;
    }
    final fresh = await _remote.getReportById(serverId);
    if (fresh == null) {
      return;
    }
    await upsertRemoteRow(fresh, source: 'seen');
  }

  Future<String?> signedUrlForLocalPhoto(LocalReport row) async {
    final path = row.photoStoragePath;
    if (path == null || path.isEmpty) {
      return row.photoUrl;
    }
    return _remote.createSignedUrlForObject(
      AppConfig.instance.faultReportsBucket,
      path,
    );
  }

  Future<String?> _readKv(String key) async {
    final q = await (_db.select(_db.syncKv)..where((k) => k.key.equals(key)))
        .getSingleOrNull();
    return q?.value;
  }

  Future<void> _writeKv(String key, String? value) async {
    await _db
        .into(_db.syncKv)
        .insertOnConflictUpdate(SyncKvCompanion(
          key: Value(key),
          value: Value(value),
        ));
  }
}
