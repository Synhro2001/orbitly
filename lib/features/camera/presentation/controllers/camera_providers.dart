import 'package:camera/camera.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'camera_providers.g.dart';

/// The phone's cameras. Empty where there are none or the plugin is missing
/// (tests, some emulators); the camera screen then says so.
@riverpod
Future<List<CameraDescription>> deviceCameras(Ref ref) async {
  try {
    return await availableCameras();
  } on Object {
    return const [];
  }
}
