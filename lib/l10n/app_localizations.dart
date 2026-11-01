import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[Locale('ru')];

  /// No description provided for @appTitle.
  ///
  /// In ru, this message translates to:
  /// **'Orbitly'**
  String get appTitle;

  /// No description provided for @brandStart.
  ///
  /// In ru, this message translates to:
  /// **'Orbit'**
  String get brandStart;

  /// No description provided for @brandAccent.
  ///
  /// In ru, this message translates to:
  /// **'ly'**
  String get brandAccent;

  /// No description provided for @errorGeneric.
  ///
  /// In ru, this message translates to:
  /// **'Что-то пошло не так'**
  String get errorGeneric;

  /// No description provided for @actionRetry.
  ///
  /// In ru, this message translates to:
  /// **'Повторить'**
  String get actionRetry;

  /// No description provided for @viewerTapToClose.
  ///
  /// In ru, this message translates to:
  /// **'Нажми, чтобы закрыть'**
  String get viewerTapToClose;

  /// No description provided for @navSystem.
  ///
  /// In ru, this message translates to:
  /// **'Система'**
  String get navSystem;

  /// No description provided for @navChats.
  ///
  /// In ru, this message translates to:
  /// **'Чаты'**
  String get navChats;

  /// No description provided for @navPlanet.
  ///
  /// In ru, this message translates to:
  /// **'Планета'**
  String get navPlanet;

  /// No description provided for @navFriends.
  ///
  /// In ru, this message translates to:
  /// **'Друзья'**
  String get navFriends;

  /// No description provided for @navCamera.
  ///
  /// In ru, this message translates to:
  /// **'Камера'**
  String get navCamera;

  /// No description provided for @moodHappy.
  ///
  /// In ru, this message translates to:
  /// **'Радость'**
  String get moodHappy;

  /// No description provided for @moodCalm.
  ///
  /// In ru, this message translates to:
  /// **'Спокойствие'**
  String get moodCalm;

  /// No description provided for @moodInLove.
  ///
  /// In ru, this message translates to:
  /// **'Влюблённость'**
  String get moodInLove;

  /// No description provided for @moodExcited.
  ///
  /// In ru, this message translates to:
  /// **'Восторг'**
  String get moodExcited;

  /// No description provided for @moodTired.
  ///
  /// In ru, this message translates to:
  /// **'Усталость'**
  String get moodTired;

  /// No description provided for @moodSad.
  ///
  /// In ru, this message translates to:
  /// **'Грусть'**
  String get moodSad;

  /// No description provided for @planetTypeOcean.
  ///
  /// In ru, this message translates to:
  /// **'Океан'**
  String get planetTypeOcean;

  /// No description provided for @planetTypeLava.
  ///
  /// In ru, this message translates to:
  /// **'Лава'**
  String get planetTypeLava;

  /// No description provided for @planetTypeIce.
  ///
  /// In ru, this message translates to:
  /// **'Лёд'**
  String get planetTypeIce;

  /// No description provided for @planetTypeJungle.
  ///
  /// In ru, this message translates to:
  /// **'Джунгли'**
  String get planetTypeJungle;

  /// No description provided for @planetTypeCandy.
  ///
  /// In ru, this message translates to:
  /// **'Конфета'**
  String get planetTypeCandy;

  /// No description provided for @planetTypeCrystal.
  ///
  /// In ru, this message translates to:
  /// **'Кристалл'**
  String get planetTypeCrystal;

  /// No description provided for @planetTypeGas.
  ///
  /// In ru, this message translates to:
  /// **'Газовый гигант'**
  String get planetTypeGas;

  /// No description provided for @streakDays.
  ///
  /// In ru, this message translates to:
  /// **'{count, plural, one{{count} день} few{{count} дня} many{{count} дней} other{{count} дня}}'**
  String streakDays(int count);

  /// No description provided for @streakCracked.
  ///
  /// In ru, this message translates to:
  /// **'Трещина: {count} дн. — 24 ч на восстановление'**
  String streakCracked(int count);

  /// No description provided for @streakBurnt.
  ///
  /// In ru, this message translates to:
  /// **'Серия сгорела'**
  String get streakBurnt;

  /// No description provided for @streakPaused.
  ///
  /// In ru, this message translates to:
  /// **'{count} дн. — на паузе, кто-то в тени'**
  String streakPaused(int count);

  /// No description provided for @systemTitle.
  ///
  /// In ru, this message translates to:
  /// **'Моя система'**
  String get systemTitle;

  /// No description provided for @systemReport.
  ///
  /// In ru, this message translates to:
  /// **'Отчёт недели'**
  String get systemReport;

  /// No description provided for @systemHint.
  ///
  /// In ru, this message translates to:
  /// **'Тяни карту · щипок — зум · нажми на планету'**
  String get systemHint;

  /// No description provided for @systemLevelChip.
  ///
  /// In ru, this message translates to:
  /// **'Ур. {level} · 🔥 {days}'**
  String systemLevelChip(int level, int days);

  /// No description provided for @systemShadowChip.
  ///
  /// In ru, this message translates to:
  /// **'🌘 В тени'**
  String get systemShadowChip;

  /// No description provided for @systemFriendPlanetShadow.
  ///
  /// In ru, this message translates to:
  /// **'Планета {name}, в тени'**
  String systemFriendPlanetShadow(String name);

  /// No description provided for @systemEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Пока на орбите пусто — добавь друзей'**
  String get systemEmpty;

  /// No description provided for @systemFriendPlanet.
  ///
  /// In ru, this message translates to:
  /// **'Планета {name}'**
  String systemFriendPlanet(String name);

  /// No description provided for @systemFriendPlanetUnread.
  ///
  /// In ru, this message translates to:
  /// **'Планета {name}, есть новый снап'**
  String systemFriendPlanetUnread(String name);

  /// No description provided for @momentOf.
  ///
  /// In ru, this message translates to:
  /// **'Момент: {name}'**
  String momentOf(String name);

  /// No description provided for @onboardingTitle.
  ///
  /// In ru, this message translates to:
  /// **'Создай свою планету'**
  String get onboardingTitle;

  /// No description provided for @onboardingSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Это твой дом во вселенной. Друзья будут вращаться вокруг него.'**
  String get onboardingSubtitle;

  /// No description provided for @onboardingTypeLabel.
  ///
  /// In ru, this message translates to:
  /// **'Тип'**
  String get onboardingTypeLabel;

  /// No description provided for @onboardingHueLabel.
  ///
  /// In ru, this message translates to:
  /// **'Оттенок'**
  String get onboardingHueLabel;

  /// No description provided for @onboardingNameLabel.
  ///
  /// In ru, this message translates to:
  /// **'Название'**
  String get onboardingNameLabel;

  /// No description provided for @onboardingNameHint.
  ///
  /// In ru, this message translates to:
  /// **'Например, Орбитания'**
  String get onboardingNameHint;

  /// No description provided for @onboardingNameError.
  ///
  /// In ru, this message translates to:
  /// **'От 2 до 20 символов'**
  String get onboardingNameError;

  /// No description provided for @onboardingCreate.
  ///
  /// In ru, this message translates to:
  /// **'Создать планету'**
  String get onboardingCreate;

  /// No description provided for @chatsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Чаты'**
  String get chatsTitle;

  /// No description provided for @chatsEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Чатов пока нет'**
  String get chatsEmpty;

  /// No description provided for @chatsLastSnap.
  ///
  /// In ru, this message translates to:
  /// **'Снап'**
  String get chatsLastSnap;

  /// No description provided for @chatsUnread.
  ///
  /// In ru, this message translates to:
  /// **'Есть непрочитанное'**
  String get chatsUnread;

  /// No description provided for @timeNow.
  ///
  /// In ru, this message translates to:
  /// **'сейчас'**
  String get timeNow;

  /// No description provided for @timeMinutes.
  ///
  /// In ru, this message translates to:
  /// **'{count} мин'**
  String timeMinutes(int count);

  /// No description provided for @timeHours.
  ///
  /// In ru, this message translates to:
  /// **'{count} ч'**
  String timeHours(int count);

  /// No description provided for @timeDays.
  ///
  /// In ru, this message translates to:
  /// **'{count} дн.'**
  String timeDays(int count);

  /// No description provided for @chatSnapTapToView.
  ///
  /// In ru, this message translates to:
  /// **'Снап — нажми, чтобы посмотреть'**
  String get chatSnapTapToView;

  /// No description provided for @chatSnapOpened.
  ///
  /// In ru, this message translates to:
  /// **'Снап просмотрен'**
  String get chatSnapOpened;

  /// No description provided for @chatSnapSent.
  ///
  /// In ru, this message translates to:
  /// **'Ты отправил снап'**
  String get chatSnapSent;

  /// No description provided for @chatSnapFrom.
  ///
  /// In ru, this message translates to:
  /// **'Снап от {name}'**
  String chatSnapFrom(String name);

  /// No description provided for @chatMessageHint.
  ///
  /// In ru, this message translates to:
  /// **'Сообщение…'**
  String get chatMessageHint;

  /// No description provided for @chatSend.
  ///
  /// In ru, this message translates to:
  /// **'Отправить'**
  String get chatSend;

  /// No description provided for @chatSharedTrophies.
  ///
  /// In ru, this message translates to:
  /// **'Общие трофеи'**
  String get chatSharedTrophies;

  /// No description provided for @chatsLastCapsule.
  ///
  /// In ru, this message translates to:
  /// **'⏳ Капсула времени'**
  String get chatsLastCapsule;

  /// No description provided for @chatStartersTitle.
  ///
  /// In ru, this message translates to:
  /// **'С чего начать?'**
  String get chatStartersTitle;

  /// No description provided for @chatCapsule.
  ///
  /// In ru, this message translates to:
  /// **'Капсула времени'**
  String get chatCapsule;

  /// No description provided for @chatCapsuleOpensIn.
  ///
  /// In ru, this message translates to:
  /// **'{count, plural, one{Откроется через {count} день} few{Откроется через {count} дня} many{Откроется через {count} дней} other{Откроется через {count} дня}}'**
  String chatCapsuleOpensIn(int count);

  /// No description provided for @chatCapsuleSealed.
  ///
  /// In ru, this message translates to:
  /// **'Запечатана до срока 🔒'**
  String get chatCapsuleSealed;

  /// No description provided for @chatCapsuleSheetTitle.
  ///
  /// In ru, this message translates to:
  /// **'Отправить в будущее'**
  String get chatCapsuleSheetTitle;

  /// No description provided for @chatCapsuleSheetSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Друг прочитает послание только в выбранный день'**
  String get chatCapsuleSheetSubtitle;

  /// No description provided for @chatCapsuleTomorrow.
  ///
  /// In ru, this message translates to:
  /// **'Завтра'**
  String get chatCapsuleTomorrow;

  /// No description provided for @chatCapsuleWeek.
  ///
  /// In ru, this message translates to:
  /// **'Через неделю'**
  String get chatCapsuleWeek;

  /// No description provided for @chatCapsuleMonth.
  ///
  /// In ru, this message translates to:
  /// **'Через месяц'**
  String get chatCapsuleMonth;

  /// No description provided for @chatCapsuleYear.
  ///
  /// In ru, this message translates to:
  /// **'Через год'**
  String get chatCapsuleYear;

  /// No description provided for @cameraFlash.
  ///
  /// In ru, this message translates to:
  /// **'Вспышка'**
  String get cameraFlash;

  /// No description provided for @cameraFlip.
  ///
  /// In ru, this message translates to:
  /// **'Сменить камеру'**
  String get cameraFlip;

  /// No description provided for @cameraShutter.
  ///
  /// In ru, this message translates to:
  /// **'Снять'**
  String get cameraShutter;

  /// No description provided for @cameraClose.
  ///
  /// In ru, this message translates to:
  /// **'Закрыть'**
  String get cameraClose;

  /// No description provided for @cameraPreviewStub.
  ///
  /// In ru, this message translates to:
  /// **'Здесь будет превью камеры'**
  String get cameraPreviewStub;

  /// No description provided for @planetLevel.
  ///
  /// In ru, this message translates to:
  /// **'Уровень {level}'**
  String planetLevel(int level);

  /// No description provided for @planetXp.
  ///
  /// In ru, this message translates to:
  /// **'{xp} / {total} XP'**
  String planetXp(int xp, int total);

  /// No description provided for @planetBestStreak.
  ///
  /// In ru, this message translates to:
  /// **'Лучшая серия'**
  String get planetBestStreak;

  /// No description provided for @planetAwards.
  ///
  /// In ru, this message translates to:
  /// **'Награды'**
  String get planetAwards;

  /// No description provided for @planetAwardLocked.
  ///
  /// In ru, this message translates to:
  /// **'Закрыто'**
  String get planetAwardLocked;

  /// No description provided for @planetMood.
  ///
  /// In ru, this message translates to:
  /// **'Настроение'**
  String get planetMood;

  /// No description provided for @planetShadowTitle.
  ///
  /// In ru, this message translates to:
  /// **'Тень'**
  String get planetShadowTitle;

  /// No description provided for @planetShadowHint.
  ///
  /// In ru, this message translates to:
  /// **'Экзамены, отпуск или просто хочется тишины? Уйди в тень — серии со всеми замрут, а друзья увидят 🌘.'**
  String get planetShadowHint;

  /// No description provided for @planetShadowDay.
  ///
  /// In ru, this message translates to:
  /// **'1 день'**
  String get planetShadowDay;

  /// No description provided for @planetShadow3Days.
  ///
  /// In ru, this message translates to:
  /// **'3 дня'**
  String get planetShadow3Days;

  /// No description provided for @planetShadowWeek.
  ///
  /// In ru, this message translates to:
  /// **'Неделя'**
  String get planetShadowWeek;

  /// No description provided for @planetShadowActive.
  ///
  /// In ru, this message translates to:
  /// **'{count, plural, one{Ты в тени ещё {count} день} few{Ты в тени ещё {count} дня} many{Ты в тени ещё {count} дней} other{Ты в тени ещё {count} дня}}'**
  String planetShadowActive(int count);

  /// No description provided for @planetShadowActiveHint.
  ///
  /// In ru, this message translates to:
  /// **'Серии на паузе. После возвращения у вас будут целые сутки, чтобы продолжить.'**
  String get planetShadowActiveHint;

  /// No description provided for @planetShadowLeave.
  ///
  /// In ru, this message translates to:
  /// **'Выйти из тени'**
  String get planetShadowLeave;

  /// No description provided for @reportTitle.
  ///
  /// In ru, this message translates to:
  /// **'Отчёт недели'**
  String get reportTitle;

  /// No description provided for @reportCloser.
  ///
  /// In ru, this message translates to:
  /// **'Приблизились'**
  String get reportCloser;

  /// No description provided for @reportDrifting.
  ///
  /// In ru, this message translates to:
  /// **'Отдаляются'**
  String get reportDrifting;

  /// No description provided for @reportWrite.
  ///
  /// In ru, this message translates to:
  /// **'Написать'**
  String get reportWrite;

  /// No description provided for @reportDelta.
  ///
  /// In ru, this message translates to:
  /// **'{delta} к близости'**
  String reportDelta(String delta);

  /// No description provided for @reportEmpty.
  ///
  /// In ru, this message translates to:
  /// **'За неделю без изменений'**
  String get reportEmpty;

  /// No description provided for @friendsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Друзья'**
  String get friendsTitle;

  /// No description provided for @friendsSearchHint.
  ///
  /// In ru, this message translates to:
  /// **'Поиск по нику'**
  String get friendsSearchHint;

  /// No description provided for @friendsSearchEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Никого не нашли'**
  String get friendsSearchEmpty;

  /// No description provided for @friendsAdd.
  ///
  /// In ru, this message translates to:
  /// **'Добавить'**
  String get friendsAdd;

  /// No description provided for @friendsRequested.
  ///
  /// In ru, this message translates to:
  /// **'Заявка отправлена'**
  String get friendsRequested;

  /// No description provided for @friendsIncoming.
  ///
  /// In ru, this message translates to:
  /// **'Входящие заявки'**
  String get friendsIncoming;

  /// No description provided for @friendsNoRequests.
  ///
  /// In ru, this message translates to:
  /// **'Новых заявок нет'**
  String get friendsNoRequests;

  /// No description provided for @friendsAccept.
  ///
  /// In ru, this message translates to:
  /// **'Принять'**
  String get friendsAccept;

  /// No description provided for @friendsDecline.
  ///
  /// In ru, this message translates to:
  /// **'Отклонить'**
  String get friendsDecline;

  /// No description provided for @friendsInviteTitle.
  ///
  /// In ru, this message translates to:
  /// **'Пригласи друга'**
  String get friendsInviteTitle;

  /// No description provided for @friendsInviteSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Отправь ссылку тем, кого хочешь видеть на своей орбите'**
  String get friendsInviteSubtitle;

  /// No description provided for @friendsCopyLink.
  ///
  /// In ru, this message translates to:
  /// **'Копировать ссылку'**
  String get friendsCopyLink;

  /// No description provided for @friendsLinkCopied.
  ///
  /// In ru, this message translates to:
  /// **'Ссылка скопирована'**
  String get friendsLinkCopied;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
