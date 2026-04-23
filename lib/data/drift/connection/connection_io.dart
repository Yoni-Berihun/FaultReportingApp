import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Opens the SQLite file used by the fixer cache (local-only).
LazyDatabase openDatabaseConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory();
    final file = File(p.join(dir.path, 'fixer_cache.sqlite'));
    if (Platform.isAndroid || Platform.isIOS) {
      return NativeDatabase.createInBackground(file);
    }
    return NativeDatabase(file);
  });
}
