import 'package:drift/drift.dart';

@DataClassName('LocalReport')
class LocalReports extends Table {
  /// Supabase `reports.id` (int8) — must fit in signed 64-bit.
  IntColumn get serverId => integer()();
  TextColumn get trackingId => text()();
  DateTimeColumn get createdAt => dateTime()();
  TextColumn get description => text()();
  TextColumn get contactNumber => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  TextColumn get commonName => text().withDefault(const Constant(''))();
  TextColumn get photoUrl => text().nullable()();
  TextColumn get photoStoragePath => text().nullable()();
  TextColumn get status => text()();
  DateTimeColumn get seenAt => dateTime().nullable()();
  DateTimeColumn get resolvedAt => dateTime().nullable()();
  DateTimeColumn get photoDeletedAt => dateTime().nullable()();
  DateTimeColumn get lastSyncedAt => dateTime().nullable()();
  /// synced | pending_seen | failed_seen
  TextColumn get localActionState =>
      text().withDefault(const Constant('synced'))();
  BoolColumn get offlineNotified => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {serverId};
}

class SyncKv extends Table {
  TextColumn get key => text()();
  TextColumn get value => text().nullable()();

  @override
  Set<Column> get primaryKey => {key};
}
