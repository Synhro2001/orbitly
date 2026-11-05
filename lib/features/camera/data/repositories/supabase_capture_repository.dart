import 'package:orbitly/features/camera/domain/repositories/capture_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseCaptureRepository implements CaptureRepository {
  const SupabaseCaptureRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<void> recordCapture() => _client.rpc<void>('record_capture');
}
