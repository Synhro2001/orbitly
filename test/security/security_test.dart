import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/core/domain/entities/shadow.dart';
import 'package:orbitly/core/domain/usecases/shadow_policy.dart';
import 'package:orbitly/features/chat/data/repositories/mock_chat_repository.dart';
import 'package:orbitly/features/chat/domain/entities/message.dart';
import 'package:orbitly/features/chat/domain/message_rules.dart';
import 'package:orbitly/features/planet/data/repositories/mock_planet_repository.dart';
import 'package:orbitly/features/system/data/repositories/mock_system_repository.dart';

/// Checks against data that the server sends or a client fakes. Users set
/// their planet look, messages and shadow themselves, so one malformed
/// record must not break the screen for all of their friends.
void main() {
  late MockStore store;

  setUp(() => store = MockStore(latency: Duration.zero, withPlanet: true));

  group('Resilience to foreign data', () {
    test('unknown planet type and mood do not break the friends list', () {
      final friend = store.friends.first;
      (friend['appearance']! as Json)['type'] = 'nebula';
      friend['mood'] = 'hyped';

      expect(
        MockSystemRepository(store).getFriends(),
        completion(hasLength(12)),
      );
    });

    test(
      'a message of an unknown kind is skipped, the chat still opens',
      () async {
        store.messages['friend-0']!.add({
          'kind': 'hologram',
          'id': 'x',
          'is_mine': false,
          'sent_at': DateTime.now().toIso8601String(),
        });

        final thread = await MockChatRepository(store).getThread('friend-0');
        expect(thread.messages.map((m) => m.id), isNot(contains('x')));
        expect(thread.messages, isNotEmpty);
      },
    );

    test('a malformed message is skipped, the chat still opens', () async {
      store.messages['friend-0']!.add({'kind': 'text', 'id': 'broken'});

      final thread = await MockChatRepository(store).getThread('friend-0');
      expect(thread.messages.map((m) => m.id), isNot(contains('broken')));
    });
  });

  group('Time capsule', () {
    test("a sealed capsule's text never reaches the recipient", () async {
      // Lera (friend-2) has a capsule that opens in 5 days.
      final thread = await MockChatRepository(store).getThread('friend-2');
      final capsule = thread.messages.whereType<CapsuleMessage>().single;

      expect(capsule.text, isNull);
    });

    test('an opened capsule arrives with its text', () async {
      final thread = await MockChatRepository(store).getThread('friend-0');
      final capsule = thread.messages.whereType<CapsuleMessage>().single;

      expect(capsule.text, isNotNull);
    });
  });

  group('Shadow', () {
    final now = DateTime(2026, 11, 1, 12);
    const policy = ShadowPolicy();

    test('a shadow up to a week is allowed', () {
      expect(
        policy.isAllowed(
          Shadow(from: now, until: now.add(const Duration(days: 7))),
          now: now,
        ),
        isTrue,
      );
    });

    test('a shadow longer than a week is rejected', () {
      expect(
        policy.isAllowed(
          Shadow(from: now, until: now.add(const Duration(days: 30))),
          now: now,
        ),
        isFalse,
      );
    });

    test('a backdated shadow cannot revive a burnt streak', () {
      expect(
        policy.isAllowed(
          Shadow(
            from: now.subtract(const Duration(days: 3)),
            until: now.add(const Duration(days: 1)),
          ),
          now: now,
        ),
        isFalse,
      );
    });

    test('ending a shadow early is allowed', () {
      final started = now.subtract(const Duration(days: 2));
      expect(
        policy.isAllowed(
          Shadow(from: started, until: now),
          now: now,
          current: Shadow(
            from: started,
            until: now.add(const Duration(days: 1)),
          ),
        ),
        isTrue,
      );
    });

    test('the server side refuses a forged shadow', () {
      final repository = MockPlanetRepository(store);

      expect(
        repository.enterShadow(const Duration(days: 365)),
        throwsArgumentError,
      );
    });
  });

  group('Message length', () {
    test('a message within the limit is valid', () {
      expect(MessageRules.isValid('Привет!'), isTrue);
    });

    test('blank and oversized messages are rejected', () {
      expect(MessageRules.isValid('   '), isFalse);
      expect(MessageRules.isValid('a' * (MessageRules.maxLength + 1)), isFalse);
    });

    test('the server side refuses an oversized message', () {
      expect(
        MockChatRepository(store)
            .sendText('friend-0', 'a' * (MessageRules.maxLength + 1)),
        throwsArgumentError,
      );
    });
  });
}
