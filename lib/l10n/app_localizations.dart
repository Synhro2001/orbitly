import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
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
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

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

  /// No description provided for @planetTypeNebula.
  ///
  /// In ru, this message translates to:
  /// **'Туманность'**
  String get planetTypeNebula;

  /// No description provided for @planetTypeBlackHole.
  ///
  /// In ru, this message translates to:
  /// **'Чёрная дыра'**
  String get planetTypeBlackHole;

  /// No description provided for @planetTypeAurora.
  ///
  /// In ru, this message translates to:
  /// **'Аврора'**
  String get planetTypeAurora;

  /// No description provided for @planetTypeSolarCorona.
  ///
  /// In ru, this message translates to:
  /// **'Солнечная корона'**
  String get planetTypeSolarCorona;

  /// No description provided for @planetTypeGemini.
  ///
  /// In ru, this message translates to:
  /// **'Близнецы'**
  String get planetTypeGemini;

  /// No description provided for @planetTypeRingWorld.
  ///
  /// In ru, this message translates to:
  /// **'Кольцевой мир'**
  String get planetTypeRingWorld;

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

  /// No description provided for @onboardingDisplayNameLabel.
  ///
  /// In ru, this message translates to:
  /// **'Как тебя зовут'**
  String get onboardingDisplayNameLabel;

  /// No description provided for @onboardingDisplayNameHint.
  ///
  /// In ru, this message translates to:
  /// **'Имя, которое увидят друзья'**
  String get onboardingDisplayNameHint;

  /// No description provided for @loginTitle.
  ///
  /// In ru, this message translates to:
  /// **'Вход в Orbitly'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Пришлём код на почту — никаких паролей'**
  String get loginSubtitle;

  /// No description provided for @loginEmailHint.
  ///
  /// In ru, this message translates to:
  /// **'Email'**
  String get loginEmailHint;

  /// No description provided for @loginSendCode.
  ///
  /// In ru, this message translates to:
  /// **'Получить код'**
  String get loginSendCode;

  /// No description provided for @loginCodeTitle.
  ///
  /// In ru, this message translates to:
  /// **'Введи код'**
  String get loginCodeTitle;

  /// No description provided for @loginCodeSubtitle.
  ///
  /// In ru, this message translates to:
  /// **'Мы отправили 6 цифр на {email}'**
  String loginCodeSubtitle(String email);

  /// No description provided for @loginCodeHint.
  ///
  /// In ru, this message translates to:
  /// **'Код из письма'**
  String get loginCodeHint;

  /// No description provided for @loginVerify.
  ///
  /// In ru, this message translates to:
  /// **'Войти'**
  String get loginVerify;

  /// No description provided for @loginChangeEmail.
  ///
  /// In ru, this message translates to:
  /// **'Другой email'**
  String get loginChangeEmail;

  /// No description provided for @loginInvalidEmail.
  ///
  /// In ru, this message translates to:
  /// **'Похоже, в адресе ошибка'**
  String get loginInvalidEmail;

  /// No description provided for @loginInvalidCode.
  ///
  /// In ru, this message translates to:
  /// **'Код не подошёл — проверь письмо'**
  String get loginInvalidCode;

  /// No description provided for @loginSendError.
  ///
  /// In ru, this message translates to:
  /// **'Не получилось отправить код. Попробуй ещё раз'**
  String get loginSendError;

  /// No description provided for @loginLocalMailHint.
  ///
  /// In ru, this message translates to:
  /// **'Локальный сервер не шлёт настоящие письма. Код — в Mailpit на компьютере: http://127.0.0.1:54324'**
  String get loginLocalMailHint;

  /// No description provided for @collectionTitle.
  ///
  /// In ru, this message translates to:
  /// **'Коллекция'**
  String get collectionTitle;

  /// No description provided for @collectionProgress.
  ///
  /// In ru, this message translates to:
  /// **'Открыто {unlocked} из {total}'**
  String collectionProgress(int unlocked, int total);

  /// No description provided for @categoryAll.
  ///
  /// In ru, this message translates to:
  /// **'Все'**
  String get categoryAll;

  /// No description provided for @categoryFriendship.
  ///
  /// In ru, this message translates to:
  /// **'Дружба'**
  String get categoryFriendship;

  /// No description provided for @categoryStreak.
  ///
  /// In ru, this message translates to:
  /// **'Серии'**
  String get categoryStreak;

  /// No description provided for @categoryCloseness.
  ///
  /// In ru, this message translates to:
  /// **'Близость'**
  String get categoryCloseness;

  /// No description provided for @categoryCollection.
  ///
  /// In ru, this message translates to:
  /// **'Коллекция'**
  String get categoryCollection;

  /// No description provided for @categorySecret.
  ///
  /// In ru, this message translates to:
  /// **'Секреты'**
  String get categorySecret;

  /// No description provided for @achievementSecretTitle.
  ///
  /// In ru, this message translates to:
  /// **'???'**
  String get achievementSecretTitle;

  /// No description provided for @achievementSecretDescription.
  ///
  /// In ru, this message translates to:
  /// **'Секретное достижение — условие узнаешь, когда откроешь'**
  String get achievementSecretDescription;

  /// No description provided for @achievementReward.
  ///
  /// In ru, this message translates to:
  /// **'Награда: {title}'**
  String achievementReward(String title);

  /// No description provided for @achievementPair.
  ///
  /// In ru, this message translates to:
  /// **'Для двоих'**
  String get achievementPair;

  /// No description provided for @achievementUnlocked.
  ///
  /// In ru, this message translates to:
  /// **'Открыто'**
  String get achievementUnlocked;

  /// No description provided for @rarityCommon.
  ///
  /// In ru, this message translates to:
  /// **'Обычное'**
  String get rarityCommon;

  /// No description provided for @rarityRare.
  ///
  /// In ru, this message translates to:
  /// **'Редкое'**
  String get rarityRare;

  /// No description provided for @rarityEpic.
  ///
  /// In ru, this message translates to:
  /// **'Эпическое'**
  String get rarityEpic;

  /// No description provided for @rarityLegendary.
  ///
  /// In ru, this message translates to:
  /// **'Легендарное'**
  String get rarityLegendary;

  /// No description provided for @wardrobeTitle.
  ///
  /// In ru, this message translates to:
  /// **'Гардероб'**
  String get wardrobeTitle;

  /// No description provided for @wardrobeEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Пока пусто — открывай достижения, и здесь появятся награды'**
  String get wardrobeEmpty;

  /// No description provided for @wardrobeEquip.
  ///
  /// In ru, this message translates to:
  /// **'Надеть'**
  String get wardrobeEquip;

  /// No description provided for @wardrobeUnequip.
  ///
  /// In ru, this message translates to:
  /// **'Снять'**
  String get wardrobeUnequip;

  /// No description provided for @cosmeticKindPlanetType.
  ///
  /// In ru, this message translates to:
  /// **'Планета'**
  String get cosmeticKindPlanetType;

  /// No description provided for @cosmeticKindMoon.
  ///
  /// In ru, this message translates to:
  /// **'Спутники'**
  String get cosmeticKindMoon;

  /// No description provided for @cosmeticKindRing.
  ///
  /// In ru, this message translates to:
  /// **'Кольца'**
  String get cosmeticKindRing;

  /// No description provided for @cosmeticKindGlow.
  ///
  /// In ru, this message translates to:
  /// **'Сияние'**
  String get cosmeticKindGlow;

  /// No description provided for @cosmeticKindCometTrail.
  ///
  /// In ru, this message translates to:
  /// **'След'**
  String get cosmeticKindCometTrail;

  /// No description provided for @unlockTitle.
  ///
  /// In ru, this message translates to:
  /// **'Новое достижение!'**
  String get unlockTitle;

  /// No description provided for @unlockEquip.
  ///
  /// In ru, this message translates to:
  /// **'Надеть'**
  String get unlockEquip;

  /// No description provided for @unlockShare.
  ///
  /// In ru, this message translates to:
  /// **'Поделиться'**
  String get unlockShare;

  /// No description provided for @unlockLater.
  ///
  /// In ru, this message translates to:
  /// **'Позже'**
  String get unlockLater;

  /// No description provided for @unlockShareSoon.
  ///
  /// In ru, this message translates to:
  /// **'Делиться наградами можно будет совсем скоро'**
  String get unlockShareSoon;

  /// No description provided for @unlockPairNote.
  ///
  /// In ru, this message translates to:
  /// **'Награда досталась и другу'**
  String get unlockPairNote;

  /// No description provided for @planetCollectionSummary.
  ///
  /// In ru, this message translates to:
  /// **'{unlocked} из {total} достижений'**
  String planetCollectionSummary(int unlocked, int total);

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

  /// No description provided for @chatSendFailed.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось отправить. Проверь связь'**
  String get chatSendFailed;

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

  /// No description provided for @chatOpenerMissYou.
  ///
  /// In ru, this message translates to:
  /// **'Привет, {name}! Давно не болтали — как ты?'**
  String chatOpenerMissYou(String name);

  /// No description provided for @chatOpenerRemindedMe.
  ///
  /// In ru, this message translates to:
  /// **'Сегодня кое-что напомнило мне о тебе 👀'**
  String get chatOpenerRemindedMe;

  /// No description provided for @chatOpenerStrangest.
  ///
  /// In ru, this message translates to:
  /// **'Что было самым странным на этой неделе?'**
  String get chatOpenerStrangest;

  /// No description provided for @chatOpenerCall.
  ///
  /// In ru, this message translates to:
  /// **'Созвонимся на выходных?'**
  String get chatOpenerCall;

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

  /// No description provided for @settingsTitle.
  ///
  /// In ru, this message translates to:
  /// **'Настройки'**
  String get settingsTitle;

  /// No description provided for @settingsLanguage.
  ///
  /// In ru, this message translates to:
  /// **'Язык'**
  String get settingsLanguage;

  /// No description provided for @settingsLanguageSystem.
  ///
  /// In ru, this message translates to:
  /// **'Как на телефоне'**
  String get settingsLanguageSystem;

  /// No description provided for @settingsAccount.
  ///
  /// In ru, this message translates to:
  /// **'Аккаунт и данные'**
  String get settingsAccount;

  /// No description provided for @settingsSignOut.
  ///
  /// In ru, this message translates to:
  /// **'Выйти'**
  String get settingsSignOut;

  /// No description provided for @settingsSignOutConfirm.
  ///
  /// In ru, this message translates to:
  /// **'Выйти из аккаунта?'**
  String get settingsSignOutConfirm;

  /// No description provided for @settingsSignOutBody.
  ///
  /// In ru, this message translates to:
  /// **'Чтобы вернуться, понадобится код из письма.'**
  String get settingsSignOutBody;

  /// No description provided for @settingsAppearance.
  ///
  /// In ru, this message translates to:
  /// **'Оформление'**
  String get settingsAppearance;

  /// No description provided for @settingsSaveFailed.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось сохранить. Проверь связь'**
  String get settingsSaveFailed;

  /// No description provided for @actionCancel.
  ///
  /// In ru, this message translates to:
  /// **'Отмена'**
  String get actionCancel;

  /// No description provided for @friendsRequestClosed.
  ///
  /// In ru, this message translates to:
  /// **'Не получилось. Возможно, этот человек принимает заявки только по своей ссылке'**
  String get friendsRequestClosed;

  /// No description provided for @inviteTitle.
  ///
  /// In ru, this message translates to:
  /// **'Приглашение'**
  String get inviteTitle;

  /// No description provided for @inviteFrom.
  ///
  /// In ru, this message translates to:
  /// **'{name} зовёт тебя на свою орбиту'**
  String inviteFrom(String name);

  /// No description provided for @inviteAccept.
  ///
  /// In ru, this message translates to:
  /// **'Добавить в друзья'**
  String get inviteAccept;

  /// No description provided for @inviteSent.
  ///
  /// In ru, this message translates to:
  /// **'Заявка отправлена'**
  String get inviteSent;

  /// No description provided for @inviteUnknown.
  ///
  /// In ru, this message translates to:
  /// **'Ссылка устарела или неверна. Попроси у друга новую'**
  String get inviteUnknown;

  /// No description provided for @settingsPrivacy.
  ///
  /// In ru, this message translates to:
  /// **'Приватность'**
  String get settingsPrivacy;

  /// No description provided for @privacySearch.
  ///
  /// In ru, this message translates to:
  /// **'Кто может найти меня по нику'**
  String get privacySearch;

  /// No description provided for @privacyRequests.
  ///
  /// In ru, this message translates to:
  /// **'Кто может отправить заявку в друзья'**
  String get privacyRequests;

  /// No description provided for @privacyMood.
  ///
  /// In ru, this message translates to:
  /// **'Кто видит моё настроение'**
  String get privacyMood;

  /// No description provided for @privacyMoments.
  ///
  /// In ru, this message translates to:
  /// **'Кто видит мои моменты'**
  String get privacyMoments;

  /// No description provided for @privacyComingSoon.
  ///
  /// In ru, this message translates to:
  /// **'Заработает вместе с новыми функциями'**
  String get privacyComingSoon;

  /// No description provided for @privacyLastSeen.
  ///
  /// In ru, this message translates to:
  /// **'Показывать, когда я был в сети'**
  String get privacyLastSeen;

  /// No description provided for @privacyReadReceipts.
  ///
  /// In ru, this message translates to:
  /// **'Отчёты о прочтении'**
  String get privacyReadReceipts;

  /// No description provided for @privacyReadReceiptsHint.
  ///
  /// In ru, this message translates to:
  /// **'Взаимно: если выключить, ты тоже не увидишь, прочитали ли тебя'**
  String get privacyReadReceiptsHint;

  /// No description provided for @privacyTyping.
  ///
  /// In ru, this message translates to:
  /// **'Показывать «печатает…»'**
  String get privacyTyping;

  /// No description provided for @privacyGalaxy.
  ///
  /// In ru, this message translates to:
  /// **'Моя система видна в «галактике» друзей'**
  String get privacyGalaxy;

  /// No description provided for @privacyGalaxyHint.
  ///
  /// In ru, this message translates to:
  /// **'Друзья друзей увидят твою планету издалека'**
  String get privacyGalaxyHint;

  /// No description provided for @audienceEveryone.
  ///
  /// In ru, this message translates to:
  /// **'Все'**
  String get audienceEveryone;

  /// No description provided for @audienceFriendsOfFriends.
  ///
  /// In ru, this message translates to:
  /// **'Друзья друзей'**
  String get audienceFriendsOfFriends;

  /// No description provided for @audienceFriends.
  ///
  /// In ru, this message translates to:
  /// **'Все друзья'**
  String get audienceFriends;

  /// No description provided for @audienceCloseOrbit.
  ///
  /// In ru, this message translates to:
  /// **'Ближняя орбита'**
  String get audienceCloseOrbit;

  /// No description provided for @audienceNobody.
  ///
  /// In ru, this message translates to:
  /// **'Никто'**
  String get audienceNobody;

  /// No description provided for @audienceCustom.
  ///
  /// In ru, this message translates to:
  /// **'Выбрать вручную'**
  String get audienceCustom;

  /// No description provided for @audienceInviteOnly.
  ///
  /// In ru, this message translates to:
  /// **'Никто, только по моей ссылке'**
  String get audienceInviteOnly;

  /// No description provided for @chatMenu.
  ///
  /// In ru, this message translates to:
  /// **'Ещё'**
  String get chatMenu;

  /// No description provided for @chatMute.
  ///
  /// In ru, this message translates to:
  /// **'В тихую орбиту'**
  String get chatMute;

  /// No description provided for @chatUnmute.
  ///
  /// In ru, this message translates to:
  /// **'Вернуть из тихой орбиты'**
  String get chatUnmute;

  /// No description provided for @chatMuted.
  ///
  /// In ru, this message translates to:
  /// **'{name} в тихой орбите: без уведомлений и подсветки. Друг об этом не узнает'**
  String chatMuted(String name);

  /// No description provided for @chatUnmuted.
  ///
  /// In ru, this message translates to:
  /// **'Снова на обычной орбите'**
  String get chatUnmuted;

  /// No description provided for @chatReport.
  ///
  /// In ru, this message translates to:
  /// **'Пожаловаться'**
  String get chatReport;

  /// No description provided for @chatBlock.
  ///
  /// In ru, this message translates to:
  /// **'Заблокировать'**
  String get chatBlock;

  /// No description provided for @blockConfirmTitle.
  ///
  /// In ru, this message translates to:
  /// **'Заблокировать {name}?'**
  String blockConfirmTitle(String name);

  /// No description provided for @blockConfirmBody.
  ///
  /// In ru, this message translates to:
  /// **'Вы перестанете быть друзьями, переписка закроется, и вы не сможете найти друг друга и написать. Разблокировать можно в настройках приватности.'**
  String get blockConfirmBody;

  /// No description provided for @unblock.
  ///
  /// In ru, this message translates to:
  /// **'Разблокировать'**
  String get unblock;

  /// No description provided for @abuseTitle.
  ///
  /// In ru, this message translates to:
  /// **'Что случилось?'**
  String get abuseTitle;

  /// No description provided for @abuseSpam.
  ///
  /// In ru, this message translates to:
  /// **'Спам или реклама'**
  String get abuseSpam;

  /// No description provided for @abuseHarassment.
  ///
  /// In ru, this message translates to:
  /// **'Травля или угрозы'**
  String get abuseHarassment;

  /// No description provided for @abuseInappropriate.
  ///
  /// In ru, this message translates to:
  /// **'Неприемлемый контент'**
  String get abuseInappropriate;

  /// No description provided for @abuseImpersonation.
  ///
  /// In ru, this message translates to:
  /// **'Выдаёт себя за другого'**
  String get abuseImpersonation;

  /// No description provided for @abuseUnderage.
  ///
  /// In ru, this message translates to:
  /// **'Похоже, младше 18 лет'**
  String get abuseUnderage;

  /// No description provided for @abuseOther.
  ///
  /// In ru, this message translates to:
  /// **'Другое'**
  String get abuseOther;

  /// No description provided for @abuseDetailsHint.
  ///
  /// In ru, this message translates to:
  /// **'Подробности (необязательно)'**
  String get abuseDetailsHint;

  /// No description provided for @abuseSend.
  ///
  /// In ru, this message translates to:
  /// **'Отправить жалобу'**
  String get abuseSend;

  /// No description provided for @abuseSent.
  ///
  /// In ru, this message translates to:
  /// **'Жалоба отправлена. Спасибо, что помогаешь'**
  String get abuseSent;

  /// No description provided for @abuseFailed.
  ///
  /// In ru, this message translates to:
  /// **'Не удалось отправить жалобу. Попробуй позже'**
  String get abuseFailed;

  /// No description provided for @settingsBlocked.
  ///
  /// In ru, this message translates to:
  /// **'Заблокированные'**
  String get settingsBlocked;

  /// No description provided for @settingsBlockedHint.
  ///
  /// In ru, this message translates to:
  /// **'Они не видят тебя и не могут написать. Разблокировка не возвращает дружбу — понадобится новая заявка.'**
  String get settingsBlockedHint;

  /// No description provided for @settingsBlockedEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Никого'**
  String get settingsBlockedEmpty;

  /// No description provided for @settingsQuietOrbit.
  ///
  /// In ru, this message translates to:
  /// **'Тихая орбита'**
  String get settingsQuietOrbit;

  /// No description provided for @settingsQuietOrbitHint.
  ///
  /// In ru, this message translates to:
  /// **'Сообщения этих друзей приходят без уведомлений, а их планеты не подсвечиваются. Друзья об этом не знают.'**
  String get settingsQuietOrbitHint;

  /// No description provided for @settingsQuietOrbitEmpty.
  ///
  /// In ru, this message translates to:
  /// **'Пока никого. Добавить друга можно в меню чата'**
  String get settingsQuietOrbitEmpty;

  /// No description provided for @actionSave.
  ///
  /// In ru, this message translates to:
  /// **'Сохранить'**
  String get actionSave;

  /// No description provided for @settingsProfile.
  ///
  /// In ru, this message translates to:
  /// **'Профиль'**
  String get settingsProfile;

  /// No description provided for @profileName.
  ///
  /// In ru, this message translates to:
  /// **'Имя'**
  String get profileName;

  /// No description provided for @profilePlanetName.
  ///
  /// In ru, this message translates to:
  /// **'Название планеты'**
  String get profilePlanetName;

  /// No description provided for @profileHandle.
  ///
  /// In ru, this message translates to:
  /// **'Ник'**
  String get profileHandle;

  /// No description provided for @profileHandleRule.
  ///
  /// In ru, this message translates to:
  /// **'менять можно раз в 30 дней'**
  String get profileHandleRule;

  /// No description provided for @profileHandleNextChange.
  ///
  /// In ru, this message translates to:
  /// **'сменить можно с {date}'**
  String profileHandleNextChange(DateTime date);

  /// No description provided for @profileHandleChecking.
  ///
  /// In ru, this message translates to:
  /// **'Проверяю…'**
  String get profileHandleChecking;

  /// No description provided for @profileHandleOk.
  ///
  /// In ru, this message translates to:
  /// **'Свободен'**
  String get profileHandleOk;

  /// No description provided for @profileHandleMine.
  ///
  /// In ru, this message translates to:
  /// **'Это твой ник сейчас'**
  String get profileHandleMine;

  /// No description provided for @profileHandleTaken.
  ///
  /// In ru, this message translates to:
  /// **'Занят'**
  String get profileHandleTaken;

  /// No description provided for @profileHandleInvalid.
  ///
  /// In ru, this message translates to:
  /// **'От 3 до 32 символов: латиница, цифры, точка, подчёркивание'**
  String get profileHandleInvalid;

  /// No description provided for @profileHandleTooSoon.
  ///
  /// In ru, this message translates to:
  /// **'Ник уже меняли меньше 30 дней назад'**
  String get profileHandleTooSoon;

  /// No description provided for @profileHandleWarning.
  ///
  /// In ru, this message translates to:
  /// **'Следующая смена — через 30 дней. Старый ник ещё 14 дней никто не сможет занять.'**
  String get profileHandleWarning;

  /// No description provided for @profileInvite.
  ///
  /// In ru, this message translates to:
  /// **'Приглашение на мою орбиту'**
  String get profileInvite;

  /// No description provided for @profileInviteHint.
  ///
  /// In ru, this message translates to:
  /// **'Покажи QR-код или отправь ссылку. По ней тебя смогут добавить, даже если поиск и заявки закрыты.'**
  String get profileInviteHint;

  /// No description provided for @profileQrLabel.
  ///
  /// In ru, this message translates to:
  /// **'QR-код приглашения'**
  String get profileQrLabel;

  /// No description provided for @profileShare.
  ///
  /// In ru, this message translates to:
  /// **'Поделиться'**
  String get profileShare;

  /// No description provided for @profileInviteShareText.
  ///
  /// In ru, this message translates to:
  /// **'Добавляйся ко мне в Orbitly: {link}'**
  String profileInviteShareText(String link);

  /// No description provided for @profileNewLink.
  ///
  /// In ru, this message translates to:
  /// **'Новая ссылка'**
  String get profileNewLink;

  /// No description provided for @profileNewLinkConfirm.
  ///
  /// In ru, this message translates to:
  /// **'Сделать новую ссылку?'**
  String get profileNewLinkConfirm;

  /// No description provided for @profileNewLinkBody.
  ///
  /// In ru, this message translates to:
  /// **'Старая ссылка и QR-код перестанут работать. Это полезно, если ссылка попала не к тем людям.'**
  String get profileNewLinkBody;

  /// No description provided for @chatRetention.
  ///
  /// In ru, this message translates to:
  /// **'Исчезающие сообщения'**
  String get chatRetention;

  /// No description provided for @chatRetentionHint.
  ///
  /// In ru, this message translates to:
  /// **'Правило общее для вас двоих и действует для новых сообщений. Капсулы не исчезают, пока не откроются.'**
  String get chatRetentionHint;

  /// No description provided for @retentionAfterSeen.
  ///
  /// In ru, this message translates to:
  /// **'Исчезают после прочтения'**
  String get retentionAfterSeen;

  /// No description provided for @retentionDay.
  ///
  /// In ru, this message translates to:
  /// **'Исчезают через 24 часа'**
  String get retentionDay;

  /// No description provided for @retentionKeep.
  ///
  /// In ru, this message translates to:
  /// **'Хранятся'**
  String get retentionKeep;

  /// No description provided for @retentionNoteAfterSeen.
  ///
  /// In ru, this message translates to:
  /// **'⏱ Сообщения исчезают через час после прочтения'**
  String get retentionNoteAfterSeen;

  /// No description provided for @retentionNoteDay.
  ///
  /// In ru, this message translates to:
  /// **'⏱ Сообщения исчезают через 24 часа'**
  String get retentionNoteDay;

  /// No description provided for @retentionNoteKeep.
  ///
  /// In ru, this message translates to:
  /// **'Сообщения хранятся'**
  String get retentionNoteKeep;

  /// No description provided for @systemLevelOnly.
  ///
  /// In ru, this message translates to:
  /// **'Ур. {level}'**
  String systemLevelOnly(int level);

  /// No description provided for @minutes.
  ///
  /// In ru, this message translates to:
  /// **'{count, plural, one{{count} минута} few{{count} минуты} many{{count} минут} other{{count} минуты}}'**
  String minutes(int count);

  /// No description provided for @settingsWellbeing.
  ///
  /// In ru, this message translates to:
  /// **'Благополучие'**
  String get settingsWellbeing;

  /// No description provided for @wellbeingShadowHint.
  ///
  /// In ru, this message translates to:
  /// **'Уйти в тень на день, три или неделю — серии замрут'**
  String get wellbeingShadowHint;

  /// No description provided for @wellbeingHideStreaks.
  ///
  /// In ru, this message translates to:
  /// **'Серии без давления'**
  String get wellbeingHideStreaks;

  /// No description provided for @wellbeingHideStreaksHint.
  ///
  /// In ru, this message translates to:
  /// **'Скрыть счётчики серий и «трещины». Серии продолжают считаться для достижений.'**
  String get wellbeingHideStreaksHint;

  /// No description provided for @wellbeingLimit.
  ///
  /// In ru, this message translates to:
  /// **'Мягкий лимит времени'**
  String get wellbeingLimit;

  /// No description provided for @wellbeingLimitHint.
  ///
  /// In ru, this message translates to:
  /// **'Напомню, сколько ты сегодня в Orbitly. Это напоминание, а не блокировка.'**
  String get wellbeingLimitHint;

  /// No description provided for @wellbeingLimitOff.
  ///
  /// In ru, this message translates to:
  /// **'Выключен'**
  String get wellbeingLimitOff;

  /// No description provided for @wellbeingReminder.
  ///
  /// In ru, this message translates to:
  /// **'{count, plural, one{Ты сегодня в Orbitly уже {count} минуту. Может, пора отдохнуть? 🌙} few{Ты сегодня в Orbitly уже {count} минуты. Может, пора отдохнуть? 🌙} many{Ты сегодня в Orbitly уже {count} минут. Может, пора отдохнуть? 🌙} other{Ты сегодня в Orbitly уже {count} минуты. Может, пора отдохнуть? 🌙}}'**
  String wellbeingReminder(int count);

  /// No description provided for @settingsNotifications.
  ///
  /// In ru, this message translates to:
  /// **'Уведомления'**
  String get settingsNotifications;

  /// No description provided for @notificationsWhat.
  ///
  /// In ru, this message translates to:
  /// **'О чём сообщать'**
  String get notificationsWhat;

  /// No description provided for @notifyMessages.
  ///
  /// In ru, this message translates to:
  /// **'Сообщения и снапы'**
  String get notifyMessages;

  /// No description provided for @notifyRequests.
  ///
  /// In ru, this message translates to:
  /// **'Заявки в друзья'**
  String get notifyRequests;

  /// No description provided for @notifyCapsules.
  ///
  /// In ru, this message translates to:
  /// **'Капсула открылась'**
  String get notifyCapsules;

  /// No description provided for @notifyShadow.
  ///
  /// In ru, this message translates to:
  /// **'Друг вышел из тени'**
  String get notifyShadow;

  /// No description provided for @notifyStreaks.
  ///
  /// In ru, this message translates to:
  /// **'Серия под угрозой'**
  String get notifyStreaks;

  /// No description provided for @notifyAchievements.
  ///
  /// In ru, this message translates to:
  /// **'Новое достижение'**
  String get notifyAchievements;

  /// No description provided for @notifyWeeklyReport.
  ///
  /// In ru, this message translates to:
  /// **'Отчёт недели'**
  String get notifyWeeklyReport;

  /// No description provided for @notificationsPreview.
  ///
  /// In ru, this message translates to:
  /// **'Что показывать в уведомлении'**
  String get notificationsPreview;

  /// No description provided for @previewFull.
  ///
  /// In ru, this message translates to:
  /// **'Текст сообщения'**
  String get previewFull;

  /// No description provided for @previewSender.
  ///
  /// In ru, this message translates to:
  /// **'Только «Новое сообщение от Ани»'**
  String get previewSender;

  /// No description provided for @previewNone.
  ///
  /// In ru, this message translates to:
  /// **'Только «Новое сообщение»'**
  String get previewNone;

  /// No description provided for @notificationsQuietHours.
  ///
  /// In ru, this message translates to:
  /// **'Тихие часы'**
  String get notificationsQuietHours;

  /// No description provided for @notificationsQuietHoursHint.
  ///
  /// In ru, this message translates to:
  /// **'В это время уведомления копятся и приходят утром одной сводкой'**
  String get notificationsQuietHoursHint;

  /// No description provided for @notificationsQuietFromTo.
  ///
  /// In ru, this message translates to:
  /// **'С {from} до {to}'**
  String notificationsQuietFromTo(String from, String to);

  /// No description provided for @notificationsSystem.
  ///
  /// In ru, this message translates to:
  /// **'Звук и вибрация'**
  String get notificationsSystem;

  /// No description provided for @notificationsSystemHint.
  ///
  /// In ru, this message translates to:
  /// **'Открыть системные настройки уведомлений'**
  String get notificationsSystemHint;

  /// No description provided for @settingsChatsMedia.
  ///
  /// In ru, this message translates to:
  /// **'Чаты и медиа'**
  String get settingsChatsMedia;

  /// No description provided for @chatsDefaultRetention.
  ///
  /// In ru, this message translates to:
  /// **'Сообщения в новых чатах'**
  String get chatsDefaultRetention;

  /// No description provided for @chatsDefaultRetentionHint.
  ///
  /// In ru, this message translates to:
  /// **'Для чата берётся более строгое правило из двух; в чате его можно поменять'**
  String get chatsDefaultRetentionHint;

  /// No description provided for @chatsMedia.
  ///
  /// In ru, this message translates to:
  /// **'Медиа'**
  String get chatsMedia;

  /// No description provided for @mediaAutoload.
  ///
  /// In ru, this message translates to:
  /// **'Автозагрузка фото и видео'**
  String get mediaAutoload;

  /// No description provided for @mediaAlways.
  ///
  /// In ru, this message translates to:
  /// **'Всегда'**
  String get mediaAlways;

  /// No description provided for @mediaWifi.
  ///
  /// In ru, this message translates to:
  /// **'Только по Wi-Fi'**
  String get mediaWifi;

  /// No description provided for @mediaNever.
  ///
  /// In ru, this message translates to:
  /// **'Никогда'**
  String get mediaNever;

  /// No description provided for @dataSaver.
  ///
  /// In ru, this message translates to:
  /// **'Экономия трафика'**
  String get dataSaver;

  /// No description provided for @dataSaverHint.
  ///
  /// In ru, this message translates to:
  /// **'Отправлять фото и видео в меньшем размере'**
  String get dataSaverHint;

  /// No description provided for @clearCache.
  ///
  /// In ru, this message translates to:
  /// **'Очистить кэш'**
  String get clearCache;

  /// No description provided for @cacheSize.
  ///
  /// In ru, this message translates to:
  /// **'Кэш: {size} МБ'**
  String cacheSize(String size);

  /// No description provided for @cacheCleared.
  ///
  /// In ru, this message translates to:
  /// **'Кэш очищен'**
  String get cacheCleared;

  /// No description provided for @appearanceHaptics.
  ///
  /// In ru, this message translates to:
  /// **'Тактильный отклик'**
  String get appearanceHaptics;

  /// No description provided for @appearanceMotion.
  ///
  /// In ru, this message translates to:
  /// **'Анимации'**
  String get appearanceMotion;

  /// No description provided for @appearanceMotionSystem.
  ///
  /// In ru, this message translates to:
  /// **'Как в системе'**
  String get appearanceMotionSystem;

  /// No description provided for @appearanceMotionReduced.
  ///
  /// In ru, this message translates to:
  /// **'Всегда меньше'**
  String get appearanceMotionReduced;

  /// No description provided for @accountEmail.
  ///
  /// In ru, this message translates to:
  /// **'Email'**
  String get accountEmail;

  /// No description provided for @accountEmailChange.
  ///
  /// In ru, this message translates to:
  /// **'Новый email'**
  String get accountEmailChange;

  /// No description provided for @accountEmailNew.
  ///
  /// In ru, this message translates to:
  /// **'Новый адрес'**
  String get accountEmailNew;

  /// No description provided for @accountEmailChanged.
  ///
  /// In ru, this message translates to:
  /// **'Email изменён'**
  String get accountEmailChanged;

  /// No description provided for @accountSignOutOthers.
  ///
  /// In ru, this message translates to:
  /// **'Выйти на других устройствах'**
  String get accountSignOutOthers;

  /// No description provided for @accountSignOutOthersHint.
  ///
  /// In ru, this message translates to:
  /// **'Этот телефон останется в аккаунте'**
  String get accountSignOutOthersHint;

  /// No description provided for @accountSignedOutOthers.
  ///
  /// In ru, this message translates to:
  /// **'Готово: другие устройства вышли из аккаунта'**
  String get accountSignedOutOthers;

  /// No description provided for @accountExport.
  ///
  /// In ru, this message translates to:
  /// **'Скачать мои данные'**
  String get accountExport;

  /// No description provided for @accountExportHint.
  ///
  /// In ru, this message translates to:
  /// **'Профиль, друзья, достижения и мои сообщения — файлом JSON'**
  String get accountExportHint;

  /// No description provided for @accountExportFailed.
  ///
  /// In ru, this message translates to:
  /// **'Не получилось собрать данные. Попробуй ещё раз'**
  String get accountExportFailed;

  /// No description provided for @accountDelete.
  ///
  /// In ru, this message translates to:
  /// **'Удалить аккаунт'**
  String get accountDelete;

  /// No description provided for @deleteWhat.
  ///
  /// In ru, this message translates to:
  /// **'Что произойдёт'**
  String get deleteWhat;

  /// No description provided for @deleteWhatProfile.
  ///
  /// In ru, this message translates to:
  /// **'Удалятся профиль, планета, достижения, награды и настройки.'**
  String get deleteWhatProfile;

  /// No description provided for @deleteWhatMessages.
  ///
  /// In ru, this message translates to:
  /// **'Удалятся все твои сообщения, снапы и капсулы.'**
  String get deleteWhatMessages;

  /// No description provided for @deleteWhatFriends.
  ///
  /// In ru, this message translates to:
  /// **'Друзья сразу перестанут тебя видеть — твоя планета исчезнет с их орбит.'**
  String get deleteWhatFriends;

  /// No description provided for @deleteWhatTrophies.
  ///
  /// In ru, this message translates to:
  /// **'Достижения, которые вы открыли вместе, у друга останутся, но без твоего имени.'**
  String get deleteWhatTrophies;

  /// No description provided for @deleteWhatGrace.
  ///
  /// In ru, this message translates to:
  /// **'Аккаунт скроется сразу, а удалится навсегда через 7 дней. Если за это время войти снова, удаление отменится.'**
  String get deleteWhatGrace;

  /// No description provided for @deleteExportFirst.
  ///
  /// In ru, this message translates to:
  /// **'Хочешь сохранить переписку и данные? Сначала скачай их в «Аккаунт и данные».'**
  String get deleteExportFirst;

  /// No description provided for @deleteSendCode.
  ///
  /// In ru, this message translates to:
  /// **'Получить код для удаления'**
  String get deleteSendCode;

  /// No description provided for @deleteConfirm.
  ///
  /// In ru, this message translates to:
  /// **'Удалить аккаунт'**
  String get deleteConfirm;

  /// No description provided for @deleteDone.
  ///
  /// In ru, this message translates to:
  /// **'Аккаунт скрыт и будет удалён {date}. Передумаешь — просто войди до этого дня.'**
  String deleteDone(DateTime date);

  /// No description provided for @deleteDoneOk.
  ///
  /// In ru, this message translates to:
  /// **'Понятно, выйти'**
  String get deleteDoneOk;

  /// No description provided for @deleteCancelled.
  ///
  /// In ru, this message translates to:
  /// **'Удаление аккаунта отменено. С возвращением!'**
  String get deleteCancelled;

  /// No description provided for @onboardingAdult.
  ///
  /// In ru, this message translates to:
  /// **'Мне есть 18 лет'**
  String get onboardingAdult;

  /// No description provided for @onboardingAdultHint.
  ///
  /// In ru, this message translates to:
  /// **'Orbitly — для взрослых'**
  String get onboardingAdultHint;

  /// No description provided for @settingsHelp.
  ///
  /// In ru, this message translates to:
  /// **'Помощь и о приложении'**
  String get settingsHelp;

  /// No description provided for @helpReportProblem.
  ///
  /// In ru, this message translates to:
  /// **'Сообщить о проблеме'**
  String get helpReportProblem;

  /// No description provided for @helpReportHint.
  ///
  /// In ru, this message translates to:
  /// **'Что случилось и как это повторить?'**
  String get helpReportHint;

  /// No description provided for @helpReportIncludes.
  ///
  /// In ru, this message translates to:
  /// **'Вместе с текстом отправятся версия приложения и модель телефона.'**
  String get helpReportIncludes;

  /// No description provided for @helpThanks.
  ///
  /// In ru, this message translates to:
  /// **'Спасибо! Мы прочитаем'**
  String get helpThanks;

  /// No description provided for @helpCommunityRules.
  ///
  /// In ru, this message translates to:
  /// **'Правила сообщества'**
  String get helpCommunityRules;

  /// No description provided for @helpPrivacyPolicy.
  ///
  /// In ru, this message translates to:
  /// **'Политика конфиденциальности'**
  String get helpPrivacyPolicy;

  /// No description provided for @helpTerms.
  ///
  /// In ru, this message translates to:
  /// **'Условия использования'**
  String get helpTerms;

  /// No description provided for @helpLicenses.
  ///
  /// In ru, this message translates to:
  /// **'Лицензии'**
  String get helpLicenses;

  /// No description provided for @helpVersion.
  ///
  /// In ru, this message translates to:
  /// **'Версия'**
  String get helpVersion;

  /// No description provided for @friendsTooMany.
  ///
  /// In ru, this message translates to:
  /// **'Слишком много запросов подряд. Подожди немного и попробуй снова'**
  String get friendsTooMany;
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
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
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
