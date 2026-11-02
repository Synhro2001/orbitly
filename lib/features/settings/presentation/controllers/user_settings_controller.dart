import 'package:orbitly/app/di.dart';
import 'package:orbitly/features/auth/presentation/controllers/auth_controller.dart';
import 'package:orbitly/features/settings/domain/entities/user_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_settings_controller.g.dart';

/// Account settings. Changes apply at once, without a "Save" button.
@Riverpod(keepAlive: true)
class UserSettingsController extends _$UserSettingsController {
  @override
  Future<UserSettings> build() {
    // Another account means other settings.
    ref.watch(signedInProvider);
    return ref.watch(userSettingsRepositoryProvider).load();
  }

  /// Shows the change at once and saves it; on a network error rolls back
  /// and rethrows, so the screen can say so. The same approach as
  /// MyPlanetController.
  Future<void> change(
    UserSettings Function(UserSettings settings) update,
  ) async {
    final previous = state.value;
    if (previous == null) return;
    final next = update(previous);
    state = AsyncData(next);
    try {
      await ref.read(userSettingsRepositoryProvider).save(next);
    } on Object {
      if (ref.mounted) state = AsyncData(previous);
      rethrow;
    }
  }
}
