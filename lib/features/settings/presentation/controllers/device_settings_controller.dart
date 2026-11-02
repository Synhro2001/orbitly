import 'package:orbitly/app/di.dart';
import 'package:orbitly/features/settings/domain/entities/device_settings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'device_settings_controller.g.dart';

/// Settings of this phone: haptics, motion, media.
@Riverpod(keepAlive: true)
class DeviceSettingsController extends _$DeviceSettingsController {
  @override
  DeviceSettings build() => ref.watch(settingsRepositoryProvider).device;

  Future<void> change(
    DeviceSettings Function(DeviceSettings settings) update,
  ) async {
    state = update(state);
    await ref.read(settingsRepositoryProvider).saveDevice(state);
  }
}
