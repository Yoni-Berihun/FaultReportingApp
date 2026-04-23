import 'package:drift/drift.dart';

import 'connection/connection_io.dart';
import 'tables/tables.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [LocalReports, SyncKv])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(openDatabaseConnection());

  static final AppDatabase instance = AppDatabase();

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {},
      );
}
