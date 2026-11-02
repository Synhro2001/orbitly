import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/core/data/models/award_model.dart';
import 'package:orbitly/core/data/models/cosmetic_model.dart';
import 'package:orbitly/core/data/supabase/friend_rows.dart';
import 'package:orbitly/core/domain/entities/award.dart';
import 'package:orbitly/core/domain/entities/cosmetic.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';

/// Rows in the shape the Supabase functions return them.
void main() {
  group('AwardModel (get_my_achievements)', () {
    test('an unlocked achievement', () {
      final award = AwardModel.fromJson({
        'id': 'week_on_orbit',
        'title': {'ru': 'Неделя на орбите', 'en': 'A week in orbit'},
        'description': {
          'ru': 'Серия 7 дней с одним другом',
          'en': 'A 7-day streak with one friend',
        },
        'icon': '🔥',
        'category': 'streak',
        'rarity': 'common',
        'hidden': false,
        'pair': false,
        'progress': 7,
        'target': 7,
        'unlocked_at': '2026-11-01T10:00:00Z',
        'seen_at': null,
        'reward_cosmetic_id': 'ring_belt',
        'reward_title': {'ru': 'Пояс астероидов', 'en': 'Asteroid belt'},
        'sort': 20,
      }).toEntity();

      expect(award.unlocked, isTrue);
      expect(award.isNew, isTrue);
      expect(award.category, AwardCategory.streak);
      expect(award.emoji, '🔥');
      expect(award.rewardId, 'ring_belt');
      expect(award.progressFraction, 1);
      expect(award.title?.inLanguage('en'), 'A week in orbit');
      expect(award.title?.inLanguage('ru'), 'Неделя на орбите');
      expect(award.rewardTitle?.inLanguage('en'), 'Asteroid belt');
    });

    test('a locked secret arrives without title and reward', () {
      final award = AwardModel.fromJson({
        'id': 'secret_01',
        'title': null,
        'description': null,
        'icon': null,
        'category': 'secret',
        'rarity': 'epic',
        'hidden': true,
        'pair': true,
        'progress': null,
        'target': null,
        'unlocked_at': null,
        'seen_at': null,
        'reward_cosmetic_id': null,
        'reward_title': null,
      }).toEntity();

      expect(award.isSecretLocked, isTrue);
      expect(award.title, isNull);
      expect(award.rewardId, isNull);
    });

    test('unknown category and rarity from a newer server fall back', () {
      final award = AwardModel.fromJson({
        'id': 'x',
        'category': 'cosmic',
        'rarity': 'mythic',
      }).toEntity();

      expect(award.category, AwardCategory.collection);
      expect(award.rarity, Rarity.common);
    });
  });

  group('CosmeticModel', () {
    test('snake_case kinds from the database', () {
      final cosmetic = CosmeticModel.fromJson({
        'id': 'trail_comet',
        'title': {'ru': 'След кометы', 'en': 'Comet trail'},
        'kind': 'comet_trail',
        'rarity': 'epic',
        'params': <String, Object?>{},
      }).toEntity();

      expect(cosmetic?.kind, CosmeticKind.cometTrail);
      expect(cosmetic?.rarity, Rarity.epic);
      expect(cosmeticKindToDb(CosmeticKind.planetType), 'planet_type');
    });

    test('a plain string title from an older server still shows', () {
      final cosmetic = CosmeticModel.fromJson({
        'id': 'ring_belt',
        'title': 'Пояс астероидов',
        'kind': 'ring',
      }).toEntity();

      expect(cosmetic?.title.inLanguage('en'), 'Пояс астероидов');
    });

    test('an unknown kind is skipped', () {
      final cosmetic = CosmeticModel.fromJson({
        'id': 'x',
        'title': 'x',
        'kind': 'hat',
      }).toEntity();

      expect(cosmetic, isNull);
    });
  });

  test('get_my_friends row: equipped cosmetics change the planet', () {
    final friend = friendFromRpcRow({
      'id': 'a0000000-0000-0000-0000-000000000002',
      'handle': 'misha_m',
      'display_name': 'Миша',
      'planet_name': 'Вулкания',
      'appearance': {'type': 'lava', 'seed': 1038, 'hue': 12},
      'equipped': [
        {
          'id': 'planet_nebula',
          'title': 'Туманность',
          'kind': 'planet_type',
          'rarity': 'rare',
          'params': {'type': 'nebula'},
        },
        {
          'id': 'moon_twin',
          'title': 'Двойник',
          'kind': 'moon',
          'rarity': 'rare',
          'params': {'moons': 2},
        },
      ],
      'mood': 'calm',
      'closeness': 74,
      'streak_days': 6,
      'last_exchange_at': '2026-10-31T12:00:00Z',
      'shadow_from': null,
      'shadow_until': null,
      'has_unread_snaps': true,
      'trophies': [
        {
          'id': 'month_together',
          'title': 'Месяц вместе',
          'icon': '🌗',
          'rarity': 'rare',
          'earned_at': '2026-10-20T12:00:00Z',
        },
      ],
    });

    expect(friend.name, 'Миша');
    expect(friend.appearance.type, PlanetType.nebula);
    expect(friend.appearance.moons, 2);
    expect(friend.appearance.seed, 1038);
    expect(friend.streak.days, 6);
    expect(friend.shadow, isNull);
    expect(friend.hasUnreadSnaps, isTrue);
    expect(friend.sharedTrophies.single.emoji, '🌗');
    expect(friend.sharedTrophies.single.unlocked, isTrue);
  });
}
