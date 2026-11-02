// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Orbitly';

  @override
  String get brandStart => 'Orbit';

  @override
  String get brandAccent => 'ly';

  @override
  String get errorGeneric => 'Что-то пошло не так';

  @override
  String get actionRetry => 'Повторить';

  @override
  String get viewerTapToClose => 'Нажми, чтобы закрыть';

  @override
  String get navSystem => 'Система';

  @override
  String get navChats => 'Чаты';

  @override
  String get navPlanet => 'Планета';

  @override
  String get navFriends => 'Друзья';

  @override
  String get navCamera => 'Камера';

  @override
  String get moodHappy => 'Радость';

  @override
  String get moodCalm => 'Спокойствие';

  @override
  String get moodInLove => 'Влюблённость';

  @override
  String get moodExcited => 'Восторг';

  @override
  String get moodTired => 'Усталость';

  @override
  String get moodSad => 'Грусть';

  @override
  String get planetTypeOcean => 'Океан';

  @override
  String get planetTypeLava => 'Лава';

  @override
  String get planetTypeIce => 'Лёд';

  @override
  String get planetTypeJungle => 'Джунгли';

  @override
  String get planetTypeCandy => 'Конфета';

  @override
  String get planetTypeCrystal => 'Кристалл';

  @override
  String get planetTypeGas => 'Газовый гигант';

  @override
  String get planetTypeNebula => 'Туманность';

  @override
  String get planetTypeBlackHole => 'Чёрная дыра';

  @override
  String get planetTypeAurora => 'Аврора';

  @override
  String get planetTypeSolarCorona => 'Солнечная корона';

  @override
  String get planetTypeGemini => 'Близнецы';

  @override
  String get planetTypeRingWorld => 'Кольцевой мир';

  @override
  String streakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count дня',
      many: '$count дней',
      few: '$count дня',
      one: '$count день',
    );
    return '$_temp0';
  }

  @override
  String streakCracked(int count) {
    return 'Трещина: $count дн. — 24 ч на восстановление';
  }

  @override
  String get streakBurnt => 'Серия сгорела';

  @override
  String streakPaused(int count) {
    return '$count дн. — на паузе, кто-то в тени';
  }

  @override
  String get systemTitle => 'Моя система';

  @override
  String get systemReport => 'Отчёт недели';

  @override
  String get systemHint => 'Тяни карту · щипок — зум · нажми на планету';

  @override
  String systemLevelChip(int level, int days) {
    return 'Ур. $level · 🔥 $days';
  }

  @override
  String get systemShadowChip => '🌘 В тени';

  @override
  String systemFriendPlanetShadow(String name) {
    return 'Планета $name, в тени';
  }

  @override
  String get systemEmpty => 'Пока на орбите пусто — добавь друзей';

  @override
  String systemFriendPlanet(String name) {
    return 'Планета $name';
  }

  @override
  String systemFriendPlanetUnread(String name) {
    return 'Планета $name, есть новый снап';
  }

  @override
  String momentOf(String name) {
    return 'Момент: $name';
  }

  @override
  String get onboardingTitle => 'Создай свою планету';

  @override
  String get onboardingSubtitle =>
      'Это твой дом во вселенной. Друзья будут вращаться вокруг него.';

  @override
  String get onboardingTypeLabel => 'Тип';

  @override
  String get onboardingHueLabel => 'Оттенок';

  @override
  String get onboardingNameLabel => 'Название';

  @override
  String get onboardingNameHint => 'Например, Орбитания';

  @override
  String get onboardingNameError => 'От 2 до 20 символов';

  @override
  String get onboardingCreate => 'Создать планету';

  @override
  String get onboardingDisplayNameLabel => 'Как тебя зовут';

  @override
  String get onboardingDisplayNameHint => 'Имя, которое увидят друзья';

  @override
  String get loginTitle => 'Вход в Orbitly';

  @override
  String get loginSubtitle => 'Пришлём код на почту — никаких паролей';

  @override
  String get loginEmailHint => 'Email';

  @override
  String get loginSendCode => 'Получить код';

  @override
  String get loginCodeTitle => 'Введи код';

  @override
  String loginCodeSubtitle(String email) {
    return 'Мы отправили 6 цифр на $email';
  }

  @override
  String get loginCodeHint => 'Код из письма';

  @override
  String get loginVerify => 'Войти';

  @override
  String get loginChangeEmail => 'Другой email';

  @override
  String get loginInvalidEmail => 'Похоже, в адресе ошибка';

  @override
  String get loginInvalidCode => 'Код не подошёл — проверь письмо';

  @override
  String get loginSendError => 'Не получилось отправить код. Попробуй ещё раз';

  @override
  String get loginLocalMailHint =>
      'Локальный сервер не шлёт настоящие письма. Код — в Mailpit на компьютере: http://127.0.0.1:54324';

  @override
  String get collectionTitle => 'Коллекция';

  @override
  String collectionProgress(int unlocked, int total) {
    return 'Открыто $unlocked из $total';
  }

  @override
  String get categoryAll => 'Все';

  @override
  String get categoryFriendship => 'Дружба';

  @override
  String get categoryStreak => 'Серии';

  @override
  String get categoryCloseness => 'Близость';

  @override
  String get categoryCollection => 'Коллекция';

  @override
  String get categorySecret => 'Секреты';

  @override
  String get achievementSecretTitle => '???';

  @override
  String get achievementSecretDescription =>
      'Секретное достижение — условие узнаешь, когда откроешь';

  @override
  String achievementReward(String title) {
    return 'Награда: $title';
  }

  @override
  String get achievementPair => 'Для двоих';

  @override
  String get achievementUnlocked => 'Открыто';

  @override
  String get rarityCommon => 'Обычное';

  @override
  String get rarityRare => 'Редкое';

  @override
  String get rarityEpic => 'Эпическое';

  @override
  String get rarityLegendary => 'Легендарное';

  @override
  String get wardrobeTitle => 'Гардероб';

  @override
  String get wardrobeEmpty =>
      'Пока пусто — открывай достижения, и здесь появятся награды';

  @override
  String get wardrobeEquip => 'Надеть';

  @override
  String get wardrobeUnequip => 'Снять';

  @override
  String get cosmeticKindPlanetType => 'Планета';

  @override
  String get cosmeticKindMoon => 'Спутники';

  @override
  String get cosmeticKindRing => 'Кольца';

  @override
  String get cosmeticKindGlow => 'Сияние';

  @override
  String get cosmeticKindCometTrail => 'След';

  @override
  String get unlockTitle => 'Новое достижение!';

  @override
  String get unlockEquip => 'Надеть';

  @override
  String get unlockShare => 'Поделиться';

  @override
  String get unlockLater => 'Позже';

  @override
  String get unlockShareSoon => 'Делиться наградами можно будет совсем скоро';

  @override
  String get unlockPairNote => 'Награда досталась и другу';

  @override
  String planetCollectionSummary(int unlocked, int total) {
    return '$unlocked из $total достижений';
  }

  @override
  String get chatsTitle => 'Чаты';

  @override
  String get chatsEmpty => 'Чатов пока нет';

  @override
  String get chatsLastSnap => 'Снап';

  @override
  String get chatsUnread => 'Есть непрочитанное';

  @override
  String get timeNow => 'сейчас';

  @override
  String timeMinutes(int count) {
    return '$count мин';
  }

  @override
  String timeHours(int count) {
    return '$count ч';
  }

  @override
  String timeDays(int count) {
    return '$count дн.';
  }

  @override
  String get chatSnapTapToView => 'Снап — нажми, чтобы посмотреть';

  @override
  String get chatSnapOpened => 'Снап просмотрен';

  @override
  String get chatSnapSent => 'Ты отправил снап';

  @override
  String chatSnapFrom(String name) {
    return 'Снап от $name';
  }

  @override
  String get chatMessageHint => 'Сообщение…';

  @override
  String get chatSend => 'Отправить';

  @override
  String get chatSendFailed => 'Не удалось отправить. Проверь связь';

  @override
  String get chatSharedTrophies => 'Общие трофеи';

  @override
  String get chatsLastCapsule => '⏳ Капсула времени';

  @override
  String get chatStartersTitle => 'С чего начать?';

  @override
  String chatOpenerMissYou(String name) {
    return 'Привет, $name! Давно не болтали — как ты?';
  }

  @override
  String get chatOpenerRemindedMe => 'Сегодня кое-что напомнило мне о тебе 👀';

  @override
  String get chatOpenerStrangest => 'Что было самым странным на этой неделе?';

  @override
  String get chatOpenerCall => 'Созвонимся на выходных?';

  @override
  String get chatCapsule => 'Капсула времени';

  @override
  String chatCapsuleOpensIn(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Откроется через $count дня',
      many: 'Откроется через $count дней',
      few: 'Откроется через $count дня',
      one: 'Откроется через $count день',
    );
    return '$_temp0';
  }

  @override
  String get chatCapsuleSealed => 'Запечатана до срока 🔒';

  @override
  String get chatCapsuleSheetTitle => 'Отправить в будущее';

  @override
  String get chatCapsuleSheetSubtitle =>
      'Друг прочитает послание только в выбранный день';

  @override
  String get chatCapsuleTomorrow => 'Завтра';

  @override
  String get chatCapsuleWeek => 'Через неделю';

  @override
  String get chatCapsuleMonth => 'Через месяц';

  @override
  String get chatCapsuleYear => 'Через год';

  @override
  String get cameraFlash => 'Вспышка';

  @override
  String get cameraFlip => 'Сменить камеру';

  @override
  String get cameraShutter => 'Снять';

  @override
  String get cameraClose => 'Закрыть';

  @override
  String get cameraPreviewStub => 'Здесь будет превью камеры';

  @override
  String planetLevel(int level) {
    return 'Уровень $level';
  }

  @override
  String planetXp(int xp, int total) {
    return '$xp / $total XP';
  }

  @override
  String get planetBestStreak => 'Лучшая серия';

  @override
  String get planetAwards => 'Награды';

  @override
  String get planetMood => 'Настроение';

  @override
  String get planetShadowTitle => 'Тень';

  @override
  String get planetShadowHint =>
      'Экзамены, отпуск или просто хочется тишины? Уйди в тень — серии со всеми замрут, а друзья увидят 🌘.';

  @override
  String get planetShadowDay => '1 день';

  @override
  String get planetShadow3Days => '3 дня';

  @override
  String get planetShadowWeek => 'Неделя';

  @override
  String planetShadowActive(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Ты в тени ещё $count дня',
      many: 'Ты в тени ещё $count дней',
      few: 'Ты в тени ещё $count дня',
      one: 'Ты в тени ещё $count день',
    );
    return '$_temp0';
  }

  @override
  String get planetShadowActiveHint =>
      'Серии на паузе. После возвращения у вас будут целые сутки, чтобы продолжить.';

  @override
  String get planetShadowLeave => 'Выйти из тени';

  @override
  String get reportTitle => 'Отчёт недели';

  @override
  String get reportCloser => 'Приблизились';

  @override
  String get reportDrifting => 'Отдаляются';

  @override
  String get reportWrite => 'Написать';

  @override
  String reportDelta(String delta) {
    return '$delta к близости';
  }

  @override
  String get reportEmpty => 'За неделю без изменений';

  @override
  String get friendsTitle => 'Друзья';

  @override
  String get friendsSearchHint => 'Поиск по нику';

  @override
  String get friendsSearchEmpty => 'Никого не нашли';

  @override
  String get friendsAdd => 'Добавить';

  @override
  String get friendsRequested => 'Заявка отправлена';

  @override
  String get friendsIncoming => 'Входящие заявки';

  @override
  String get friendsNoRequests => 'Новых заявок нет';

  @override
  String get friendsAccept => 'Принять';

  @override
  String get friendsDecline => 'Отклонить';

  @override
  String get friendsInviteTitle => 'Пригласи друга';

  @override
  String get friendsInviteSubtitle =>
      'Отправь ссылку тем, кого хочешь видеть на своей орбите';

  @override
  String get friendsCopyLink => 'Копировать ссылку';

  @override
  String get friendsLinkCopied => 'Ссылка скопирована';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get settingsLanguage => 'Язык';

  @override
  String get settingsLanguageSystem => 'Как на телефоне';

  @override
  String get settingsAccount => 'Аккаунт и данные';

  @override
  String get settingsSignOut => 'Выйти';

  @override
  String get settingsSignOutConfirm => 'Выйти из аккаунта?';

  @override
  String get settingsSignOutBody =>
      'Чтобы вернуться, понадобится код из письма.';

  @override
  String get settingsAppearance => 'Оформление';

  @override
  String get settingsSaveFailed => 'Не удалось сохранить. Проверь связь';

  @override
  String get actionCancel => 'Отмена';

  @override
  String get friendsRequestClosed =>
      'Не получилось. Возможно, этот человек принимает заявки только по своей ссылке';

  @override
  String get inviteTitle => 'Приглашение';

  @override
  String inviteFrom(String name) {
    return '$name зовёт тебя на свою орбиту';
  }

  @override
  String get inviteAccept => 'Добавить в друзья';

  @override
  String get inviteSent => 'Заявка отправлена';

  @override
  String get inviteUnknown =>
      'Ссылка устарела или неверна. Попроси у друга новую';

  @override
  String get settingsPrivacy => 'Приватность';

  @override
  String get privacySearch => 'Кто может найти меня по нику';

  @override
  String get privacyRequests => 'Кто может отправить заявку в друзья';

  @override
  String get privacyMood => 'Кто видит моё настроение';

  @override
  String get privacyMoments => 'Кто видит мои моменты';

  @override
  String get privacyComingSoon => 'Заработает вместе с новыми функциями';

  @override
  String get privacyLastSeen => 'Показывать, когда я был в сети';

  @override
  String get privacyReadReceipts => 'Отчёты о прочтении';

  @override
  String get privacyReadReceiptsHint =>
      'Взаимно: если выключить, ты тоже не увидишь, прочитали ли тебя';

  @override
  String get privacyTyping => 'Показывать «печатает…»';

  @override
  String get privacyGalaxy => 'Моя система видна в «галактике» друзей';

  @override
  String get privacyGalaxyHint => 'Друзья друзей увидят твою планету издалека';

  @override
  String get audienceEveryone => 'Все';

  @override
  String get audienceFriendsOfFriends => 'Друзья друзей';

  @override
  String get audienceFriends => 'Все друзья';

  @override
  String get audienceCloseOrbit => 'Ближняя орбита';

  @override
  String get audienceNobody => 'Никто';

  @override
  String get audienceCustom => 'Выбрать вручную';

  @override
  String get audienceInviteOnly => 'Никто, только по моей ссылке';

  @override
  String get chatMenu => 'Ещё';

  @override
  String get chatMute => 'В тихую орбиту';

  @override
  String get chatUnmute => 'Вернуть из тихой орбиты';

  @override
  String chatMuted(String name) {
    return '$name в тихой орбите: без уведомлений и подсветки. Друг об этом не узнает';
  }

  @override
  String get chatUnmuted => 'Снова на обычной орбите';

  @override
  String get chatReport => 'Пожаловаться';

  @override
  String get chatBlock => 'Заблокировать';

  @override
  String blockConfirmTitle(String name) {
    return 'Заблокировать $name?';
  }

  @override
  String get blockConfirmBody =>
      'Вы перестанете быть друзьями, переписка закроется, и вы не сможете найти друг друга и написать. Разблокировать можно в настройках приватности.';

  @override
  String get unblock => 'Разблокировать';

  @override
  String get abuseTitle => 'Что случилось?';

  @override
  String get abuseSpam => 'Спам или реклама';

  @override
  String get abuseHarassment => 'Травля или угрозы';

  @override
  String get abuseInappropriate => 'Неприемлемый контент';

  @override
  String get abuseImpersonation => 'Выдаёт себя за другого';

  @override
  String get abuseUnderage => 'Похоже, младше 18 лет';

  @override
  String get abuseOther => 'Другое';

  @override
  String get abuseDetailsHint => 'Подробности (необязательно)';

  @override
  String get abuseSend => 'Отправить жалобу';

  @override
  String get abuseSent => 'Жалоба отправлена. Спасибо, что помогаешь';

  @override
  String get abuseFailed => 'Не удалось отправить жалобу. Попробуй позже';

  @override
  String get settingsBlocked => 'Заблокированные';

  @override
  String get settingsBlockedHint =>
      'Они не видят тебя и не могут написать. Разблокировка не возвращает дружбу — понадобится новая заявка.';

  @override
  String get settingsBlockedEmpty => 'Никого';

  @override
  String get settingsQuietOrbit => 'Тихая орбита';

  @override
  String get settingsQuietOrbitHint =>
      'Сообщения этих друзей приходят без уведомлений, а их планеты не подсвечиваются. Друзья об этом не знают.';

  @override
  String get settingsQuietOrbitEmpty =>
      'Пока никого. Добавить друга можно в меню чата';

  @override
  String get actionSave => 'Сохранить';

  @override
  String get settingsProfile => 'Профиль';

  @override
  String get profileName => 'Имя';

  @override
  String get profilePlanetName => 'Название планеты';

  @override
  String get profileHandle => 'Ник';

  @override
  String get profileHandleRule => 'менять можно раз в 30 дней';

  @override
  String profileHandleNextChange(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'сменить можно с $dateString';
  }

  @override
  String get profileHandleChecking => 'Проверяю…';

  @override
  String get profileHandleOk => 'Свободен';

  @override
  String get profileHandleMine => 'Это твой ник сейчас';

  @override
  String get profileHandleTaken => 'Занят';

  @override
  String get profileHandleInvalid =>
      'От 3 до 32 символов: латиница, цифры, точка, подчёркивание';

  @override
  String get profileHandleTooSoon => 'Ник уже меняли меньше 30 дней назад';

  @override
  String get profileHandleWarning =>
      'Следующая смена — через 30 дней. Старый ник ещё 14 дней никто не сможет занять.';

  @override
  String get profileInvite => 'Приглашение на мою орбиту';

  @override
  String get profileInviteHint =>
      'Покажи QR-код или отправь ссылку. По ней тебя смогут добавить, даже если поиск и заявки закрыты.';

  @override
  String get profileQrLabel => 'QR-код приглашения';

  @override
  String get profileShare => 'Поделиться';

  @override
  String profileInviteShareText(String link) {
    return 'Добавляйся ко мне в Orbitly: $link';
  }

  @override
  String get profileNewLink => 'Новая ссылка';

  @override
  String get profileNewLinkConfirm => 'Сделать новую ссылку?';

  @override
  String get profileNewLinkBody =>
      'Старая ссылка и QR-код перестанут работать. Это полезно, если ссылка попала не к тем людям.';

  @override
  String get chatRetention => 'Исчезающие сообщения';

  @override
  String get chatRetentionHint =>
      'Правило общее для вас двоих и действует для новых сообщений. Капсулы не исчезают, пока не откроются.';

  @override
  String get retentionAfterSeen => 'Исчезают после прочтения';

  @override
  String get retentionDay => 'Исчезают через 24 часа';

  @override
  String get retentionKeep => 'Хранятся';

  @override
  String get retentionNoteAfterSeen =>
      '⏱ Сообщения исчезают через час после прочтения';

  @override
  String get retentionNoteDay => '⏱ Сообщения исчезают через 24 часа';

  @override
  String get retentionNoteKeep => 'Сообщения хранятся';
}
