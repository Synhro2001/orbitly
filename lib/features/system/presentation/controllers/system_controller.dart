import 'package:orbitly/app/di.dart';
import 'package:orbitly/core/domain/entities/friend.dart';
import 'package:orbitly/features/system/domain/entities/moment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'system_controller.g.dart';

typedef SystemData = ({List<Friend> friends, List<Moment> moments});

@riverpod
class SystemController extends _$SystemController {
  @override
  Future<SystemData> build() async {
    final repository = ref.watch(systemRepositoryProvider);
    final (friends, moments) = await (
      repository.getFriends(),
      repository.getMoments(),
    ).wait;
    return (friends: friends, moments: moments);
  }

  Future<void> markMomentSeen(String momentId) async {
    await ref.read(systemRepositoryProvider).markMomentSeen(momentId);
    final current = state.value;
    if (!ref.mounted || current == null) return;
    state = AsyncData((
      friends: current.friends,
      moments: [
        for (final m in current.moments)
          if (m.id == momentId) m.copyWith(seen: true) else m,
      ],
    ));
  }
}
