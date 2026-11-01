// Фейковый бэкенд в памяти. Хранит данные в виде JSON, как их отдал бы
// сервер, чтобы mock-репозитории проходили тот же путь
// JSON → модель → сущность.
// Удаляется целиком при подключении Supabase.

typedef Json = Map<String, Object?>;

class MockStore {
  MockStore({
    DateTime? now,
    this.latency = const Duration(milliseconds: 350),
    bool withPlanet = false,
  }) : _now = now ?? DateTime.now() {
    _seed();
    if (withPlanet) {
      createPlanet('Орбитания', {
        'type': 'ocean',
        'seed': 7,
        'hue': 200.0,
        'moons': 1,
        'has_rings': true,
        'glows': true,
      });
    }
  }

  final DateTime _now;

  /// Имитация сети.
  final Duration latency;

  Future<void> delay() => Future<void>.delayed(latency);

  Json? myPlanet;
  final friends = <Json>[];
  final messages = <String, List<Json>>{};
  final sharedTrophyIds = <String, List<String>>{};
  final awards = <Json>[];
  final moments = <Json>[];
  final incomingRequests = <Json>[];
  final directory = <Json>[];
  final weeklyReport = <String, List<Json>>{};

  int _idCounter = 0;
  String nextId(String prefix) => '$prefix-${_idCounter++}';

  String _ago(Duration d) => _now.subtract(d).toIso8601String();

  /// Друг с вычисленным флагом непрочитанных снапов.
  Json friendJson(String id) {
    final friend = friends.firstWhere((f) => f['id'] == id);
    final hasUnread = (messages[id] ?? const <Json>[]).any(
      (m) =>
          m['kind'] == 'snap' && m['is_mine'] == false && m['opened'] == false,
    );
    return {...friend, 'has_unread_snaps': hasUnread};
  }

  List<Json> friendsJson() => [
    for (final f in friends) friendJson(f['id']! as String),
  ];

  void createPlanet(String name, Json appearance) {
    myPlanet = {
      'name': name,
      'handle': 'me',
      'appearance': appearance,
      'level': 4,
      'xp': 340,
      'xp_for_next_level': 500,
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
    // Часы с последнего обмена: большинство активны, пара в «трещине»,
    // одна серия сгорела.
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
          'glows': glows,
        },
        'closeness': closeness,
        'streak_days': streakDays[i],
        'last_exchange_at': _ago(Duration(hours: hoursSinceExchange[i])),
        'mood': moods[i % moods.length],
        // Паша на неделе экзаменов ушёл в тень — его серия на паузе.
        if (i == 7) ...{
          'shadow_from': _ago(const Duration(days: 2)),
          'shadow_until': _now.add(const Duration(days: 1)).toIso8601String(),
        },
      });
      messages[id] = _conversation(i, unreadSnap: const {0, 3, 7}.contains(i));
      sharedTrophyIds[id] = [
        'award-0',
        if (closeness > 50) 'award-1',
        if (closeness > 75) 'award-3',
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

    const awardSeed = [
      ('Первый контакт', '🛰️', true),
      ('Неделя на орбите', '🔥', true),
      ('Ночная смена', '🌙', true),
      ('Лучшие друзья', '💫', true),
      ('Месяц без перерыва', '☄️', false),
      ('Звёздный фотограф', '📸', false),
      ('Душа компании', '🪐', false),
      ('Сто снапов', '💯', false),
      ('Сверхновая', '🌟', false),
    ];
    for (final (i, a) in awardSeed.indexed) {
      awards.add({
        'id': 'award-$i',
        'title': a.$1,
        'emoji': a.$2,
        'unlocked': a.$3,
      });
    }

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

    // Капсулы времени: от Ани — уже открылась, от Леры — ещё запечатана.
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

  /// Подсказки «с чего начать» — только для тех, с кем общение затихает:
  /// друг в списке отдаляющихся или с последнего обмена прошли сутки.
  List<String> conversationStarters(String friendId) {
    final friend = friends.firstWhere((f) => f['id'] == friendId);
    final last = DateTime.parse(friend['last_exchange_at']! as String);
    final drifting = (weeklyReport['drifting'] ?? const <Json>[]).any(
      (row) => row['friend_id'] == friendId,
    );
    if (!drifting && _now.difference(last) < const Duration(hours: 24)) {
      return const [];
    }
    final name = friend['name']! as String;
    return [
      'Привет, $name! Давно не болтали — как ты?',
      'Сегодня кое-что напомнило мне о тебе 👀',
      'Что было самым странным на этой неделе?',
      'Созвонимся на выходных?',
    ];
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
