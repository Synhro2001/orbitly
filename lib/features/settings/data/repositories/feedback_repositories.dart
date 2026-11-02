import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/features/settings/domain/repositories/feedback_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseFeedbackRepository implements FeedbackRepository {
  const SupabaseFeedbackRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<void> submit(
    String message, {
    required String appVersion,
    required String device,
  }) => _client.rpc<void>(
    'submit_feedback',
    params: {
      'p_message': message,
      'p_app_version': appVersion,
      'p_device': device,
    },
  );
}

class MockFeedbackRepository implements FeedbackRepository {
  const MockFeedbackRepository(this._store);

  final MockStore _store;

  @override
  Future<void> submit(
    String message, {
    required String appVersion,
    required String device,
  }) async {
    await _store.delay();
    _store.feedback.add({
      'message': message.trim(),
      'app_version': appVersion,
      'device': device,
    });
  }
}
