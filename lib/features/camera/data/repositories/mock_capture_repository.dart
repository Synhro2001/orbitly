import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/features/camera/domain/repositories/capture_repository.dart';

class MockCaptureRepository implements CaptureRepository {
  const MockCaptureRepository(this._store);

  final MockStore _store;

  @override
  Future<void> recordCapture() async {
    await _store.delay();
    _store.recordCapture();
  }
}
