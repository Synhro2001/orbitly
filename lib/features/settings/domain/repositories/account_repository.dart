/// Deleting the account and downloading my data.
abstract interface class AccountRepository {
  /// Hides the account at once; it is deleted for good on the returned
  /// date. Needs a session confirmed with a fresh code from email.
  Future<DateTime> requestDeletion();

  /// True if a deletion was waiting and has been cancelled.
  Future<bool> cancelDeletion();

  /// Everything the app keeps about me, as JSON.
  Future<Map<String, Object?>> exportData();
}
