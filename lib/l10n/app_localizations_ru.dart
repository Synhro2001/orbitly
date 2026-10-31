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
  String get chatsTitle => 'Чаты';

  @override
  String get chatsEmpty => 'Чатов пока нет';

  @override
  String get chatsLastSnap => 'Снап';

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
  String get chatSharedTrophies => 'Общие трофеи';

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
  String get planetAwardLocked => 'Закрыто';

  @override
  String get planetMood => 'Настроение';

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
