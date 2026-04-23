import 'package:flutter_test/flutter_test.dart';
import 'package:fault_reporting_app/services/fixer_sync_policy.dart';

void main() {
  test('offline notification only when offline window is set and report is new enough', () {
    final t0 = DateTime.utc(2025, 1, 1, 12, 0);
    expect(
      FixerSyncPolicy.isEligibleForOfflineNotification(
        reportCreatedAt: t0,
        offlineStartedAt: null,
      ),
      false,
    );
    expect(
      FixerSyncPolicy.isEligibleForOfflineNotification(
        reportCreatedAt: t0,
        offlineStartedAt: DateTime.utc(2025, 1, 1, 10, 0),
      ),
      true,
    );
    expect(
      FixerSyncPolicy.isEligibleForOfflineNotification(
        reportCreatedAt: DateTime.utc(2025, 1, 1, 9, 0),
        offlineStartedAt: DateTime.utc(2025, 1, 1, 10, 0),
      ),
      false,
    );
  });
}
