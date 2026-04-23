/// Pure helpers for when to show “missed while offline” notifications.
class FixerSyncPolicy {
  const FixerSyncPolicy._();

  /// Reports created at or after the moment we first noticed being offline
  /// should be eligible for a reconnect batch notification.
  static bool isEligibleForOfflineNotification({
    required DateTime reportCreatedAt,
    required DateTime? offlineStartedAt,
  }) {
    if (offlineStartedAt == null) {
      return false;
    }
    // Compare in UTC; Supabase is timestamptz.
    return !reportCreatedAt.isBefore(offlineStartedAt.toUtc());
  }
}
