/// Photos taken with the app's camera.
///
/// Stage 1 of photo achievements: the photo stays on the phone and the
/// server only learns that it was taken. The server decides what that
/// unlocks; new unlocks arrive through AchievementsRepository.watchUnlocks.
abstract interface class CaptureRepository {
  Future<void> recordCapture();
}
