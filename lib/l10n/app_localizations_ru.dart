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
}
