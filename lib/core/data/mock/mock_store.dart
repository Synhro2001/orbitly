// In-memory fake backend. Keeps data as JSON, the way the server would
// return it, so mock repositories go through the same
// JSON → model → entity path.
// Used when USE_MOCKS=true: in tests and when running offline.

import 'dart:async';

typedef Json = Map<String, Object?>;

class MockStore {
  MockStore({
    DateTime? now,
    this.latency = const Duration(milliseconds: 350),
    bool withPlanet = false,
    this.withNewUnlock = false,
  }) : _now = now ?? DateTime.now() {
    _seed();
    if (withPlanet) {
      createPlanet('Орбитания', {'type': 'ocean', 'seed': 7, 'hue': 200.0});
      // The moon and the rings are rewards already worn.
      equipped.addAll(['moon_first', 'ring_belt']);
    }
  }

  final DateTime _now;

  /// "Time keeper" is unlocked but not shown yet, so the unlock animation
  /// plays on start. Off in tests so it does not cover the screen.
  final bool withNewUnlock;

  /// New unlocks, like Supabase Realtime.
  final unlocks = StreamController<String>.broadcast();

  /// Simulated network delay.
  final Duration latency;

  Future<void> delay() => Future<void>.delayed(latency);

  Json? myPlanet;
  final friends = <Json>[];
  final messages = <String, List<Json>>{};
  final sharedTrophyIds = <String, List<String>>{};

  /// Achievement catalogue with my progress, shaped like the rows of
  /// get_my_achievements() in Supabase.
  final achievements = <Json>[];
  final cosmetics = <Json>[];

  /// Unlocked cosmetics and which of them are worn.
  final owned = <String>{};
  final equipped = <String>{};
  final moments = <Json>[];
  final incomingRequests = <Json>[];
  final directory = <Json>[];
  final weeklyReport = <String, List<Json>>{};

  /// My account settings, shaped like a `user_settings` row. Empty means
  /// all defaults.
  Json settings = {};

  /// People I blocked (user summaries), friends I muted, reports I filed.
  final blocked = <Json>[];
  final muted = <String>{};
  final reports = <Json>[];

  /// The code in my invite link.
  String inviteCode = 'my-invite';

  int _idCounter = 0;
  String nextId(String prefix) => '$prefix-${_idCounter++}';

  String _ago(Duration d) => _now.subtract(d).toIso8601String();

  /// A friend with the computed "has unread snaps" flag.
  Json friendJson(String id) {
    final friend = friends.firstWhere((f) => f['id'] == id);
    final hasUnread = (messages[id] ?? const <Json>[]).any(
      (m) =>
          m['kind'] == 'snap' && m['is_mine'] == false && m['opened'] == false,
    );
    return {
      ...friend,
      'has_unread_snaps': hasUnread,
      'muted': muted.contains(id),
      'trophies': [
        for (final id in sharedTrophyIds[id] ?? const <String>[])
          achievements.firstWhere((a) => a['id'] == id),
      ],
    };
  }

  List<Json> friendsJson() => [
    for (final f in friends) friendJson(f['id']! as String),
  ];

  void createPlanet(String name, Json appearance) {
    myPlanet = {
      'planet_name': name,
      'handle': 'me',
      'appearance': appearance,
      // Level 4 = 450…800 XP (level = floor(sqrt(xp / 50)) + 1).
      'level': 4,
      'xp': 600,
      'best_streak_days': 27,
      'mood': 'happy',
    };
  }

  void _seed() {
    const people = [
      ('Аня', 'anya.sky', 'ocean', 190.0, 92, 1, true, false),
      ('Миша', 'misha_m', 'lava', 12.0, 85, 0, false, true),
      ('Лера', 'lera.moon', 'candy', 320.0, 78, 2, false, true),
      ('Дима', 'dimon', 'gas', 35.0, 70, 1, true, false),
      ('Катя', 'katya.k', 'jungle', 120.0, 64, 0, false, false),
      ('Саша', 'sasha_orbit', 'crystal', 270.0, 58, 3, false, true),
      ('Вика', 'vika.v', 'ice', 205.0, 49, 1, true, false),
      ('Паша', 'pasha_p', 'gas', 260.0, 41, 2, true, false),
      ('Оля', 'olya.sun', 'candy', 30.0, 33, 0, false, true),
      ('Егор', 'egor.e', 'lava', 350.0, 24, 1, false, false),
      ('Соня', 'sonya.s', 'ocean', 160.0, 16, 0, true, false),
      ('Тимур', 'timur.t', 'crystal', 175.0, 8, 2, false, false),
    ];
    const moods = ['happy', 'calm', 'inLove', 'excited', 'tired', 'sad'];
    // Hours since the last exchange: most are active, a couple are
    // cracked, one streak is lost.
    const hoursSinceExchange = [2, 5, 1, 30, 8, 12, 3, 40, 20, 60, 6, 10];
    const streakDays = [48, 31, 22, 15, 12, 9, 7, 5, 4, 0, 2, 1];

    for (var i = 0; i < people.length; i++) {
      final (name, handle, type, hue, closeness, moons, rings, glows) =
          people[i];
      final id = 'friend-$i';
      friends.add({
        'id': id,
        'name': name,
        'handle': handle,
        'appearance': {
          'type': type,
          'seed': 1000 + i * 37,
          'hue': hue,
          'moons': moons,
          'has_rings': rings,
          'glow': glows ? 'soft' : 'none',
        },
        'closeness': closeness,
        'streak_days': streakDays[i],
        'last_exchange_at': _ago(Duration(hours: hoursSinceExchange[i])),
        'mood': moods[i % moods.length],
        // Pasha went into shadow for exam week, so his streak is paused.
        if (i == 7) ...{
          'shadow_from': _ago(const Duration(days: 2)),
          'shadow_until': _now.add(const Duration(days: 1)).toIso8601String(),
        },
      });
      messages[id] = _conversation(i, unreadSnap: const {0, 3, 7}.contains(i));
      sharedTrophyIds[id] = [
        'first_contact',
        if (closeness > 50) 'week_on_orbit',
        if (closeness > 75) 'month_together',
      ];
    }

    for (final (i, seen) in const [
      (1, false),
      (2, false),
      (4, false),
      (5, true),
      (8, true),
      (10, true),
    ]) {
      moments.add({
        'id': 'moment-$i',
        'friend_id': 'friend-$i',
        'seen': seen,
        'posted_at': _ago(Duration(hours: i + 1)),
      });
    }

    _seedAchievements();

    incomingRequests.addAll([
      {
        'id': 'request-0',
        'user': _user('user-10', 'Ника', 'nika.star', 'jungle', 95),
        'sent_at': _ago(const Duration(hours: 3)),
      },
      {
        'id': 'request-1',
        'user': _user('user-11', 'Рома', 'roma_r', 'ice', 230),
        'sent_at': _ago(const Duration(days: 1)),
      },
    ]);
    directory.addAll([
      _user('user-1', 'Алиса', 'alisa.a', 'candy', 300),
      _user('user-2', 'Артём', 'artem.space', 'gas', 20),
      _user('user-3', 'Мила', 'mila.m', 'ocean', 210),
      _user('user-4', 'Макс', 'max_orbit', 'lava', 5),
      _user('user-5', 'Ася', 'asya.sky', 'crystal', 285),
      _user('user-6', 'Лев', 'lev.l', 'jungle', 100),
    ]);

    weeklyReport['closer'] = [
      {'friend_id': 'friend-2', 'delta': 12},
      {'friend_id': 'friend-4', 'delta': 8},
      {'friend_id': 'friend-6', 'delta': 5},
    ];
    weeklyReport['drifting'] = [
      {'friend_id': 'friend-9', 'delta': -14},
      {'friend_id': 'friend-11', 'delta': -9},
      {'friend_id': 'friend-7', 'delta': -4},
    ];

    // Time capsules: Anya's has opened, Lera's is still sealed.
    messages['friend-0']!.insert(0, {
      'kind': 'capsule',
      'id': 'capsule-0',
      'is_mine': false,
      'sent_at': _ago(const Duration(days: 30)),
      'opens_at': _ago(const Duration(hours: 20)),
      'text':
          'Привет из прошлого месяца! Если читаешь это — экзамен '
          'позади. Горжусь тобой 🍀',
    });
    messages['friend-2']!.insert(0, {
      'kind': 'capsule',
      'id': 'capsule-1',
      'is_mine': false,
      'sent_at': _ago(const Duration(days: 1)),
      'opens_at': _now.add(const Duration(days: 5)).toIso8601String(),
      'text': 'С днём рождения! Открой меня вовремя 🎂',
    });
  }

  /// Unlocks an achievement the way the server does: progress, reward and
  /// a Realtime event.
  void unlock(String achievementId) {
    final row = achievements.firstWhere((a) => a['id'] == achievementId);
    if (row['unlocked_at'] != null) return;
    row
      ..['unlocked_at'] = DateTime.now().toIso8601String()
      ..['seen_at'] = null
      ..['progress'] = row['target'];
    if (row['reward_cosmetic_id'] case final String reward) owned.add(reward);
    unlocks.add(achievementId);
  }

  /// The friend is drifting away or has been quiet for a day, so the chat
  /// suggests how to restart the conversation.
  bool isDrifting(String friendId) {
    final friend = friends.firstWhere((f) => f['id'] == friendId);
    final last = DateTime.parse(friend['last_exchange_at']! as String);
    final drifting = (weeklyReport['drifting'] ?? const <Json>[]).any(
      (row) => row['friend_id'] == friendId,
    );
    return drifting || _now.difference(last) >= const Duration(hours: 24);
  }

  void _seedAchievements() {
    cosmetics.addAll([
      for (final (id, title, kind, rarity, params) in const [
        (
          'moon_first',
          {'ru': 'Первый спутник', 'en': 'First moon'},
          'moon',
          'common',
          {'moons': 1},
        ),
        (
          'moon_hourglass',
          {'ru': 'Песочные часы', 'en': 'Hourglass'},
          'moon',
          'common',
          {'moons': 1, 'skin': 'hourglass'},
        ),
        (
          'moon_twin',
          {'ru': 'Двойник', 'en': 'Twin'},
          'moon',
          'rare',
          {'moons': 2},
        ),
        (
          'ring_belt',
          {'ru': 'Пояс астероидов', 'en': 'Asteroid belt'},
          'ring',
          'common',
          <String, Object?>{},
        ),
        (
          'planet_ring_world',
          {'ru': 'Кольцевой мир', 'en': 'Ring world'},
          'planet_type',
          'rare',
          {'type': 'ringWorld'},
        ),
        (
          'planet_nebula',
          {'ru': 'Туманность', 'en': 'Nebula'},
          'planet_type',
          'rare',
          {'type': 'nebula'},
        ),
      ])
        {
          'id': id,
          'title': title,
          'kind': kind,
          'rarity': rarity,
          'params': params,
        },
    ]);

    // (id, title, description, icon, category, rarity, progress, target,
    //  unlocked days ago or null, secret, pair, reward)
    const catalog = [
      (
        'first_contact',
        {'ru': 'Первый контакт', 'en': 'First contact'},
        {
          'ru': 'Найди первого друга на орбите',
          'en': 'Find your first friend in orbit',
        },
        '🛰️',
        'friendship',
        'common',
        1,
        1,
        60,
        false,
        false,
        'moon_first',
      ),
      (
        'week_on_orbit',
        {'ru': 'Неделя на орбите', 'en': 'A week in orbit'},
        {
          'ru': 'Серия 7 дней с одним другом',
          'en': 'A 7-day streak with one friend',
        },
        '🔥',
        'streak',
        'common',
        7,
        7,
        40,
        false,
        false,
        'ring_belt',
      ),
      (
        'time_keeper',
        {'ru': 'Хранитель времени', 'en': 'Time keeper'},
        {
          'ru': 'Открой первую капсулу времени',
          'en': 'Open your first time capsule',
        },
        '⏳',
        'collection',
        'common',
        1,
        1,
        0,
        false,
        false,
        'moon_hourglass',
      ),
      (
        'month_together',
        {'ru': 'Месяц вместе', 'en': 'A month together'},
        {
          'ru': 'Серия 30 дней с другом — общий спутник вам обоим',
          'en': 'A 30-day streak with a friend: a shared moon for you both',
        },
        '🌗',
        'streak',
        'rare',
        30,
        30,
        18,
        false,
        true,
        'moon_twin',
      ),
      (
        'constellation',
        {'ru': 'Созвездие', 'en': 'Constellation'},
        {'ru': 'Пять друзей на орбите', 'en': 'Five friends in orbit'},
        '✨',
        'friendship',
        'rare',
        5,
        5,
        30,
        false,
        false,
        'planet_ring_world',
      ),
      (
        'own_galaxy',
        {'ru': 'Своя галактика', 'en': 'Your own galaxy'},
        {'ru': 'Десять друзей на орбите', 'en': 'Ten friends in orbit'},
        '🌌',
        'friendship',
        'rare',
        10,
        10,
        9,
        false,
        false,
        'planet_nebula',
      ),
      (
        'comeback',
        {'ru': 'Возвращение', 'en': 'Comeback'},
        {
          'ru': 'Вернись из тени и продолжи серию',
          'en': 'Come back from the shadow and keep your streak',
        },
        '🌘',
        'streak',
        'rare',
        0,
        1,
        null,
        false,
        false,
        'glow_aurora',
      ),
      (
        'polar_night',
        {'ru': 'Полярная ночь', 'en': 'Polar night'},
        {
          'ru': 'Три раза вернись из тени, не потеряв серию',
          'en': 'Come back from the shadow three times without losing a streak',
        },
        '🌠',
        'collection',
        'rare',
        0,
        3,
        null,
        false,
        false,
        'planet_aurora',
      ),
      (
        'double_star',
        {'ru': 'Двойная звезда', 'en': 'Double star'},
        {
          'ru': 'Близость 90+ с другом 30 дней подряд',
          'en': 'Closeness 90+ with a friend for 30 days in a row',
        },
        '💫',
        'closeness',
        'epic',
        24,
        30,
        null,
        false,
        true,
        'glow_double_star',
      ),
      (
        'hundred_days',
        {'ru': 'Сто дней', 'en': 'A hundred days'},
        {'ru': 'Серия 100 дней', 'en': 'A 100-day streak'},
        '☄️',
        'streak',
        'epic',
        48,
        100,
        null,
        false,
        false,
        'trail_comet',
      ),
      (
        'secret_01',
        null,
        null,
        null,
        'secret',
        'epic',
        null,
        null,
        null,
        true,
        true,
        null,
      ),
      (
        'secret_02',
        null,
        null,
        null,
        'secret',
        'epic',
        null,
        null,
        null,
        true,
        false,
        null,
      ),
      (
        'year_of_friendship',
        {'ru': 'Год дружбы', 'en': 'A year of friendship'},
        {'ru': 'Серия 365 дней', 'en': 'A 365-day streak'},
        '👑',
        'streak',
        'legendary',
        48,
        365,
        null,
        false,
        false,
        'planet_solar_corona',
      ),
    ];
    for (final (
          id,
          title,
          description,
          icon,
          category,
          rarity,
          progress,
          target,
          unlockedDaysAgo,
          hidden,
          pair,
          reward,
        )
        in catalog) {
      final rewardTitle = cosmetics
          .where((c) => c['id'] == reward)
          .map((c) => c['title'])
          .firstOrNull;
      achievements.add({
        'id': id,
        'title': title,
        'description': description,
        'icon': icon,
        'category': category,
        'rarity': rarity,
        'hidden': hidden,
        'pair': pair,
        'progress': progress,
        'target': target,
        'unlocked_at': unlockedDaysAgo == null
            ? null
            : _ago(Duration(days: unlockedDaysAgo)),
        'seen_at':
            unlockedDaysAgo == null || (id == 'time_keeper' && withNewUnlock)
            ? null
            : _ago(Duration(days: unlockedDaysAgo)),
        'reward_cosmetic_id': reward,
        'reward_title': rewardTitle,
      });
      if (unlockedDaysAgo != null && reward != null) owned.add(reward);
    }
  }

  Json _user(String id, String name, String handle, String type, double hue) =>
      {
        'id': id,
        'name': name,
        'handle': handle,
        'appearance': {'type': type, 'seed': id.hashCode & 0xFFFF, 'hue': hue},
      };

  List<Json> _conversation(int i, {required bool unreadSnap}) {
    const dialogues = [
      ['Ты видел закат сегодня?', 'Да! Небо было как на Марсе', 'Скинь фотку'],
      ['Идём в субботу в кино?', 'Давай, на вечерний', 'Беру билеты 🎟️'],
      ['Как прошёл экзамен?', 'Сдала на отлично!', 'Горжусь тобой ✨'],
      ['Смотри, что нашёл', 'Ахаха, это же мы', 'Ставлю на аватарку'],
      ['Ты дома?', 'Через полчаса буду', 'Зайду за книгой'],
      ['Скучаю по лету', 'Скоро снова море', 'Считаю дни 🌊'],
    ];
    final lines = dialogues[i % dialogues.length];
    final result = <Json>[
      for (final (j, text) in lines.indexed)
        {
          'kind': 'text',
          'id': 'msg-$i-$j',
          'is_mine': j.isOdd,
          'sent_at': _ago(Duration(minutes: 240 - j * 30)),
          'text': text,
        },
      {
        'kind': 'snap',
        'id': 'msg-$i-opened',
        'is_mine': true,
        'sent_at': _ago(const Duration(minutes: 120)),
        'opened': true,
      },
    ];
    if (unreadSnap) {
      result.add({
        'kind': 'snap',
        'id': 'msg-$i-unread',
        'is_mine': false,
        'sent_at': _ago(const Duration(minutes: 15)),
        'opened': false,
      });
    }
    return result;
  }
}
