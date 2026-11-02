import 'package:orbitly/core/data/supabase/friend_rows.dart';
import 'package:orbitly/core/domain/entities/friend.dart';
import 'package:orbitly/features/system/domain/entities/moment.dart';
import 'package:orbitly/features/system/domain/repositories/system_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseSystemRepository implements SystemRepository {
  const SupabaseSystemRepository(this._client);

  final SupabaseClient _client;

  @override
  Future<List<Friend>> getFriends() => fetchMyFriends(_client);

  /// Моменты появятся вместе с историями и хранилищем медиа.
  @override
  Future<List<Moment>> getMoments() async => const [];

  @override
  Future<void> markMomentSeen(String momentId) async {}
}
