import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/app/di.dart';
import 'package:orbitly/features/settings/data/models/user_settings_model.dart';
import 'package:orbitly/features/settings/domain/entities/user_settings.dart';
import 'package:orbitly/features/settings/domain/repositories/user_settings_repository.dart';
import 'package:orbitly/features/settings/presentation/controllers/user_settings_controller.dart';

/// Loads defaults; every save fails, like a phone without network.
class _OfflineSettings implements UserSettingsRepository {
  @override
  Future<UserSettings> load() async => const UserSettings();

  @override
  Future<void> save(UserSettings settings) async => throw StateError('Offline');
}

void main() {
  group('UserSettingsModel', () {
    test('an empty row gives the private defaults', () {
      final settings = UserSettingsModel.fromJson(const {}).toEntity();
      expect(settings, const UserSettings());
      expect(settings.searchVisibility, SearchVisibility.friendsOfFriends);
      expect(settings.requestPolicy, RequestPolicy.friendsOfFriends);
      expect(settings.showLastSeen, isFalse);
      expect(settings.galaxyVisible, isFalse);
      expect(settings.messageRetention, MessageRetention.day);
      expect(settings.quietFromMinute, 23 * 60);
      expect(settings.quietToMinute, 8 * 60);
    });

    test('a database row maps to the settings', () {
      final settings = UserSettingsModel.fromJson(const {
        'user_id': 'a0000000-0000-0000-0000-000000000001',
        'search_visibility': 'nobody',
        'request_policy': 'inviteOnly',
        'mood_audience': 'closeOrbit',
        'quiet_from': '22:30:00',
        'quiet_to': '07:15:00',
        'daily_limit_minutes': 30,
        'message_retention': 'afterSeen',
        'updated_at': '2026-11-03T10:00:00Z',
      }).toEntity();
      expect(settings.searchVisibility, SearchVisibility.nobody);
      expect(settings.requestPolicy, RequestPolicy.inviteOnly);
      expect(settings.moodAudience, MoodAudience.closeOrbit);
      expect(settings.quietFromMinute, 22 * 60 + 30);
      expect(settings.quietToMinute, 7 * 60 + 15);
      expect(settings.dailyLimitMinutes, 30);
      expect(settings.messageRetention, MessageRetention.afterSeen);
    });

    test('unknown values from a newer server fall back to the defaults', () {
      final settings = UserSettingsModel.fromJson(const {
        'search_visibility': 'aliens',
        'message_retention': 'forever',
        'quiet_from': 'soon',
      }).toEntity();
      expect(settings.searchVisibility, SearchVisibility.friendsOfFriends);
      expect(settings.messageRetention, MessageRetention.day);
      expect(settings.quietFromMinute, 23 * 60);
    });

    test('settings survive a round trip through JSON', () {
      const settings = UserSettings(
        searchVisibility: SearchVisibility.everyone,
        quietFromMinute: 21 * 60 + 5,
        dailyLimitMinutes: 90,
        hideStreaks: true,
      );
      final json = UserSettingsModel.fromEntity(settings).toJson();
      expect(json['quiet_from'], '21:05:00');
      expect(json['search_visibility'], 'everyone');
      expect(UserSettingsModel.fromJson(json).toEntity(), settings);
    });
  });

  test('a failed save rolls the setting back', () async {
    final container = ProviderContainer(
      overrides: [
        userSettingsRepositoryProvider.overrideWithValue(_OfflineSettings()),
      ],
    );
    addTearDown(container.dispose);
    await container.read(userSettingsControllerProvider.future);

    final change = container
        .read(userSettingsControllerProvider.notifier)
        .change((s) => s.copyWith(showLastSeen: true));
    // The screen shows the change at once…
    expect(
      container.read(userSettingsControllerProvider).value?.showLastSeen,
      isTrue,
    );
    // …and goes back when the save fails.
    await expectLater(change, throwsStateError);
    expect(
      container.read(userSettingsControllerProvider).value?.showLastSeen,
      isFalse,
    );
  });
}
