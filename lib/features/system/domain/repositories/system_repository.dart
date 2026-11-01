import 'package:orbitly/core/domain/entities/friend.dart';
import 'package:orbitly/features/system/domain/entities/moment.dart';

abstract interface class SystemRepository {
  Future<List<Friend>> getFriends();

  Future<List<Moment>> getMoments();

  Future<void> markMomentSeen(String momentId);
}
