/// "Report a problem": the text plus what helps to reproduce it.
abstract interface class FeedbackRepository {
  Future<void> submit(
    String message, {
    required String appVersion,
    required String device,
  });
}
