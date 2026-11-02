// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Orbitly';

  @override
  String get brandStart => 'Orbit';

  @override
  String get brandAccent => 'ly';

  @override
  String get errorGeneric => 'Something went wrong';

  @override
  String get actionRetry => 'Try again';

  @override
  String get viewerTapToClose => 'Tap to close';

  @override
  String get navSystem => 'System';

  @override
  String get navChats => 'Chats';

  @override
  String get navPlanet => 'Planet';

  @override
  String get navFriends => 'Friends';

  @override
  String get navCamera => 'Camera';

  @override
  String get moodHappy => 'Happy';

  @override
  String get moodCalm => 'Calm';

  @override
  String get moodInLove => 'In love';

  @override
  String get moodExcited => 'Excited';

  @override
  String get moodTired => 'Tired';

  @override
  String get moodSad => 'Sad';

  @override
  String get planetTypeOcean => 'Ocean';

  @override
  String get planetTypeLava => 'Lava';

  @override
  String get planetTypeIce => 'Ice';

  @override
  String get planetTypeJungle => 'Jungle';

  @override
  String get planetTypeCandy => 'Candy';

  @override
  String get planetTypeCrystal => 'Crystal';

  @override
  String get planetTypeGas => 'Gas giant';

  @override
  String get planetTypeNebula => 'Nebula';

  @override
  String get planetTypeBlackHole => 'Black hole';

  @override
  String get planetTypeAurora => 'Aurora';

  @override
  String get planetTypeSolarCorona => 'Solar corona';

  @override
  String get planetTypeGemini => 'Gemini';

  @override
  String get planetTypeRingWorld => 'Ring world';

  @override
  String streakDays(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '$count day',
    );
    return '$_temp0';
  }

  @override
  String streakCracked(int count) {
    return 'Cracked: $count d — 24 h to save it';
  }

  @override
  String get streakBurnt => 'Streak lost';

  @override
  String streakPaused(int count) {
    return '$count d — paused, someone is in the shadow';
  }

  @override
  String get systemTitle => 'My system';

  @override
  String get systemReport => 'Weekly report';

  @override
  String get systemHint => 'Drag the map · pinch to zoom · tap a planet';

  @override
  String systemLevelChip(int level, int days) {
    return 'Lv. $level · 🔥 $days';
  }

  @override
  String get systemShadowChip => '🌘 In shadow';

  @override
  String systemFriendPlanetShadow(String name) {
    return '$name\'s planet, in shadow';
  }

  @override
  String get systemEmpty => 'Your orbit is empty for now — add friends';

  @override
  String systemFriendPlanet(String name) {
    return '$name\'s planet';
  }

  @override
  String systemFriendPlanetUnread(String name) {
    return '$name\'s planet, new snap';
  }

  @override
  String momentOf(String name) {
    return 'Moment: $name';
  }

  @override
  String get onboardingTitle => 'Create your planet';

  @override
  String get onboardingSubtitle =>
      'This is your home in the universe. Your friends will orbit around it.';

  @override
  String get onboardingTypeLabel => 'Type';

  @override
  String get onboardingHueLabel => 'Hue';

  @override
  String get onboardingNameLabel => 'Name';

  @override
  String get onboardingNameHint => 'For example, Orbitania';

  @override
  String get onboardingNameError => '2 to 20 characters';

  @override
  String get onboardingCreate => 'Create planet';

  @override
  String get onboardingDisplayNameLabel => 'Your name';

  @override
  String get onboardingDisplayNameHint => 'The name your friends will see';

  @override
  String get loginTitle => 'Sign in to Orbitly';

  @override
  String get loginSubtitle => 'We\'ll email you a code — no passwords';

  @override
  String get loginEmailHint => 'Email';

  @override
  String get loginSendCode => 'Get code';

  @override
  String get loginCodeTitle => 'Enter the code';

  @override
  String loginCodeSubtitle(String email) {
    return 'We sent 6 digits to $email';
  }

  @override
  String get loginCodeHint => 'Code from the email';

  @override
  String get loginVerify => 'Sign in';

  @override
  String get loginChangeEmail => 'Use another email';

  @override
  String get loginInvalidEmail => 'That address doesn\'t look right';

  @override
  String get loginInvalidCode => 'That code didn\'t work — check the email';

  @override
  String get loginSendError => 'Couldn\'t send the code. Please try again';

  @override
  String get loginLocalMailHint =>
      'The local server doesn\'t send real emails. The code is in Mailpit on your computer: http://127.0.0.1:54324';

  @override
  String get collectionTitle => 'Collection';

  @override
  String collectionProgress(int unlocked, int total) {
    return '$unlocked of $total unlocked';
  }

  @override
  String get categoryAll => 'All';

  @override
  String get categoryFriendship => 'Friendship';

  @override
  String get categoryStreak => 'Streaks';

  @override
  String get categoryCloseness => 'Closeness';

  @override
  String get categoryCollection => 'Collection';

  @override
  String get categorySecret => 'Secrets';

  @override
  String get achievementSecretTitle => '???';

  @override
  String get achievementSecretDescription =>
      'A secret achievement — you\'ll find out how once you unlock it';

  @override
  String achievementReward(String title) {
    return 'Reward: $title';
  }

  @override
  String get achievementPair => 'For two';

  @override
  String get achievementUnlocked => 'Unlocked';

  @override
  String get rarityCommon => 'Common';

  @override
  String get rarityRare => 'Rare';

  @override
  String get rarityEpic => 'Epic';

  @override
  String get rarityLegendary => 'Legendary';

  @override
  String get wardrobeTitle => 'Wardrobe';

  @override
  String get wardrobeEmpty =>
      'Nothing here yet — unlock achievements and your rewards will appear here';

  @override
  String get wardrobeEquip => 'Wear';

  @override
  String get wardrobeUnequip => 'Take off';

  @override
  String get cosmeticKindPlanetType => 'Planet';

  @override
  String get cosmeticKindMoon => 'Moons';

  @override
  String get cosmeticKindRing => 'Rings';

  @override
  String get cosmeticKindGlow => 'Glow';

  @override
  String get cosmeticKindCometTrail => 'Trail';

  @override
  String get unlockTitle => 'New achievement!';

  @override
  String get unlockEquip => 'Wear';

  @override
  String get unlockShare => 'Share';

  @override
  String get unlockLater => 'Later';

  @override
  String get unlockShareSoon => 'Sharing rewards is coming very soon';

  @override
  String get unlockPairNote => 'Your friend got the reward too';

  @override
  String planetCollectionSummary(int unlocked, int total) {
    return '$unlocked of $total achievements';
  }

  @override
  String get chatsTitle => 'Chats';

  @override
  String get chatsEmpty => 'No chats yet';

  @override
  String get chatsLastSnap => 'Snap';

  @override
  String get chatsUnread => 'Unread';

  @override
  String get timeNow => 'now';

  @override
  String timeMinutes(int count) {
    return '$count min';
  }

  @override
  String timeHours(int count) {
    return '$count h';
  }

  @override
  String timeDays(int count) {
    return '$count d';
  }

  @override
  String get chatSnapTapToView => 'Snap — tap to view';

  @override
  String get chatSnapOpened => 'Snap viewed';

  @override
  String get chatSnapSent => 'You sent a snap';

  @override
  String chatSnapFrom(String name) {
    return 'Snap from $name';
  }

  @override
  String get chatMessageHint => 'Message…';

  @override
  String get chatSend => 'Send';

  @override
  String get chatSendFailed => 'Couldn\'t send. Check your connection';

  @override
  String get chatSharedTrophies => 'Shared trophies';

  @override
  String get chatsLastCapsule => '⏳ Time capsule';

  @override
  String get chatStartersTitle => 'Not sure how to start?';

  @override
  String chatOpenerMissYou(String name) {
    return 'Hi $name! It\'s been a while — how are you?';
  }

  @override
  String get chatOpenerRemindedMe => 'Something reminded me of you today 👀';

  @override
  String get chatOpenerStrangest => 'What was the strangest thing this week?';

  @override
  String get chatOpenerCall => 'Call this weekend?';

  @override
  String get chatCapsule => 'Time capsule';

  @override
  String chatCapsuleOpensIn(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Opens in $count days',
      one: 'Opens in $count day',
    );
    return '$_temp0';
  }

  @override
  String get chatCapsuleSealed => 'Sealed until the date 🔒';

  @override
  String get chatCapsuleSheetTitle => 'Send to the future';

  @override
  String get chatCapsuleSheetSubtitle =>
      'Your friend can read it only on the day you pick';

  @override
  String get chatCapsuleTomorrow => 'Tomorrow';

  @override
  String get chatCapsuleWeek => 'In a week';

  @override
  String get chatCapsuleMonth => 'In a month';

  @override
  String get chatCapsuleYear => 'In a year';

  @override
  String get cameraFlash => 'Flash';

  @override
  String get cameraFlip => 'Switch camera';

  @override
  String get cameraShutter => 'Take photo';

  @override
  String get cameraClose => 'Close';

  @override
  String get cameraPreviewStub => 'Camera preview goes here';

  @override
  String planetLevel(int level) {
    return 'Level $level';
  }

  @override
  String planetXp(int xp, int total) {
    return '$xp / $total XP';
  }

  @override
  String get planetBestStreak => 'Best streak';

  @override
  String get planetAwards => 'Awards';

  @override
  String get planetMood => 'Mood';

  @override
  String get planetShadowTitle => 'Shadow';

  @override
  String get planetShadowHint =>
      'Exams, a holiday or just need some quiet? Go into the shadow — all your streaks freeze, and friends will see 🌘.';

  @override
  String get planetShadowDay => '1 day';

  @override
  String get planetShadow3Days => '3 days';

  @override
  String get planetShadowWeek => 'A week';

  @override
  String planetShadowActive(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'You\'re in the shadow for $count more days',
      one: 'You\'re in the shadow for $count more day',
    );
    return '$_temp0';
  }

  @override
  String get planetShadowActiveHint =>
      'Streaks are paused. When you\'re back, you\'ll have a full day to continue them.';

  @override
  String get planetShadowLeave => 'Leave the shadow';

  @override
  String get reportTitle => 'Weekly report';

  @override
  String get reportCloser => 'Getting closer';

  @override
  String get reportDrifting => 'Drifting apart';

  @override
  String get reportWrite => 'Message';

  @override
  String reportDelta(String delta) {
    return '$delta closeness';
  }

  @override
  String get reportEmpty => 'No changes this week';

  @override
  String get friendsTitle => 'Friends';

  @override
  String get friendsSearchHint => 'Search by username';

  @override
  String get friendsSearchEmpty => 'No one found';

  @override
  String get friendsAdd => 'Add';

  @override
  String get friendsRequested => 'Request sent';

  @override
  String get friendsIncoming => 'Friend requests';

  @override
  String get friendsNoRequests => 'No new requests';

  @override
  String get friendsAccept => 'Accept';

  @override
  String get friendsDecline => 'Decline';

  @override
  String get friendsInviteTitle => 'Invite a friend';

  @override
  String get friendsInviteSubtitle =>
      'Send a link to the people you want in your orbit';

  @override
  String get friendsCopyLink => 'Copy link';

  @override
  String get friendsLinkCopied => 'Link copied';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get settingsLanguage => 'Language';

  @override
  String get settingsLanguageSystem => 'Same as the phone';

  @override
  String get settingsAccount => 'Account and data';

  @override
  String get settingsSignOut => 'Sign out';

  @override
  String get settingsSignOutConfirm => 'Sign out?';

  @override
  String get settingsSignOutBody =>
      'You\'ll need a code from your email to come back.';

  @override
  String get settingsAppearance => 'Appearance';

  @override
  String get settingsSaveFailed => 'Couldn\'t save. Check your connection';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get friendsRequestClosed =>
      'Didn\'t work. This person may only accept requests through their own link';

  @override
  String get inviteTitle => 'Invite';

  @override
  String inviteFrom(String name) {
    return '$name invites you into their orbit';
  }

  @override
  String get inviteAccept => 'Add friend';

  @override
  String get inviteSent => 'Request sent';

  @override
  String get inviteUnknown =>
      'This link is old or wrong. Ask your friend for a new one';

  @override
  String get settingsPrivacy => 'Privacy';

  @override
  String get privacySearch => 'Who can find me by username';

  @override
  String get privacyRequests => 'Who can send me friend requests';

  @override
  String get privacyMood => 'Who sees my mood';

  @override
  String get privacyMoments => 'Who sees my moments';

  @override
  String get privacyComingSoon => 'Starts working with upcoming features';

  @override
  String get privacyLastSeen => 'Show when I was last online';

  @override
  String get privacyReadReceipts => 'Read receipts';

  @override
  String get privacyReadReceiptsHint =>
      'Mutual: turn them off and you won\'t see others\' either';

  @override
  String get privacyTyping => 'Show “typing…”';

  @override
  String get privacyGalaxy => 'My system shows in friends\' “galaxy”';

  @override
  String get privacyGalaxyHint =>
      'Friends of friends will see your planet from afar';

  @override
  String get audienceEveryone => 'Everyone';

  @override
  String get audienceFriendsOfFriends => 'Friends of friends';

  @override
  String get audienceFriends => 'All friends';

  @override
  String get audienceCloseOrbit => 'Close orbit';

  @override
  String get audienceNobody => 'Nobody';

  @override
  String get audienceCustom => 'Choose manually';

  @override
  String get audienceInviteOnly => 'Nobody, only through my link';

  @override
  String get chatMenu => 'More';

  @override
  String get chatMute => 'Move to quiet orbit';

  @override
  String get chatUnmute => 'Bring back from quiet orbit';

  @override
  String chatMuted(String name) {
    return '$name is in your quiet orbit: no notifications or glow. They won\'t know';
  }

  @override
  String get chatUnmuted => 'Back on a normal orbit';

  @override
  String get chatReport => 'Report';

  @override
  String get chatBlock => 'Block';

  @override
  String blockConfirmTitle(String name) {
    return 'Block $name?';
  }

  @override
  String get blockConfirmBody =>
      'You\'ll stop being friends, the chat will close, and you won\'t be able to find or message each other. You can unblock in privacy settings.';

  @override
  String get unblock => 'Unblock';

  @override
  String get abuseTitle => 'What happened?';

  @override
  String get abuseSpam => 'Spam or ads';

  @override
  String get abuseHarassment => 'Bullying or threats';

  @override
  String get abuseInappropriate => 'Inappropriate content';

  @override
  String get abuseImpersonation => 'Pretending to be someone else';

  @override
  String get abuseUnderage => 'Seems to be under 18';

  @override
  String get abuseOther => 'Something else';

  @override
  String get abuseDetailsHint => 'Details (optional)';

  @override
  String get abuseSend => 'Send report';

  @override
  String get abuseSent => 'Report sent. Thanks for helping';

  @override
  String get abuseFailed => 'Couldn\'t send the report. Try again later';

  @override
  String get settingsBlocked => 'Blocked';

  @override
  String get settingsBlockedHint =>
      'They can\'t see you or message you. Unblocking doesn\'t restore the friendship — a new request is needed.';

  @override
  String get settingsBlockedEmpty => 'No one';

  @override
  String get settingsQuietOrbit => 'Quiet orbit';

  @override
  String get settingsQuietOrbitHint =>
      'Messages from these friends come without notifications, and their planets don\'t glow. They don\'t know.';

  @override
  String get settingsQuietOrbitEmpty =>
      'No one yet. Add a friend from the chat menu';

  @override
  String get actionSave => 'Save';

  @override
  String get settingsProfile => 'Profile';

  @override
  String get profileName => 'Name';

  @override
  String get profilePlanetName => 'Planet name';

  @override
  String get profileHandle => 'Username';

  @override
  String get profileHandleRule => 'can be changed once in 30 days';

  @override
  String profileHandleNextChange(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat.yMMMd(localeName);
    final String dateString = dateDateFormat.format(date);

    return 'can be changed from $dateString';
  }

  @override
  String get profileHandleChecking => 'Checking…';

  @override
  String get profileHandleOk => 'Available';

  @override
  String get profileHandleMine => 'This is your username now';

  @override
  String get profileHandleTaken => 'Taken';

  @override
  String get profileHandleInvalid =>
      '3 to 32 characters: latin letters, digits, dot, underscore';

  @override
  String get profileHandleTooSoon =>
      'The username was changed less than 30 days ago';

  @override
  String get profileHandleWarning =>
      'The next change is possible in 30 days. Nobody can take the old username for 14 days.';

  @override
  String get profileInvite => 'Invite to my orbit';

  @override
  String get profileInviteHint =>
      'Show the QR code or send the link. People can add you with it even when search and requests are closed.';

  @override
  String get profileQrLabel => 'Invite QR code';

  @override
  String get profileShare => 'Share';

  @override
  String profileInviteShareText(String link) {
    return 'Join me on Orbitly: $link';
  }

  @override
  String get profileNewLink => 'New link';

  @override
  String get profileNewLinkConfirm => 'Make a new link?';

  @override
  String get profileNewLinkBody =>
      'The old link and QR code will stop working. Useful if the link reached the wrong people.';

  @override
  String get chatRetention => 'Disappearing messages';

  @override
  String get chatRetentionHint =>
      'The rule is shared by you both and applies to new messages. Capsules don\'t disappear before they open.';

  @override
  String get retentionAfterSeen => 'Disappear after being read';

  @override
  String get retentionDay => 'Disappear after 24 hours';

  @override
  String get retentionKeep => 'Kept';

  @override
  String get retentionNoteAfterSeen =>
      '⏱ Messages disappear an hour after being read';

  @override
  String get retentionNoteDay => '⏱ Messages disappear after 24 hours';

  @override
  String get retentionNoteKeep => 'Messages are kept';

  @override
  String systemLevelOnly(int level) {
    return 'Lv. $level';
  }

  @override
  String minutes(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count minutes',
      one: '$count minute',
    );
    return '$_temp0';
  }

  @override
  String get settingsWellbeing => 'Wellbeing';

  @override
  String get wellbeingShadowHint =>
      'Go into the shadow for a day, three or a week — streaks freeze';

  @override
  String get wellbeingHideStreaks => 'Streaks without pressure';

  @override
  String get wellbeingHideStreaksHint =>
      'Hide streak counters and cracks. Streaks still count for achievements.';

  @override
  String get wellbeingLimit => 'Soft time limit';

  @override
  String get wellbeingLimitHint =>
      'I\'ll remind you how long you\'ve been in Orbitly today. A reminder, not a lock.';

  @override
  String get wellbeingLimitOff => 'Off';

  @override
  String wellbeingReminder(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other:
          'You\'ve spent $count minutes in Orbitly today. Time for a break? 🌙',
      one: 'You\'ve spent $count minute in Orbitly today. Time for a break? 🌙',
    );
    return '$_temp0';
  }

  @override
  String get settingsNotifications => 'Notifications';

  @override
  String get notificationsWhat => 'Notify me about';

  @override
  String get notifyMessages => 'Messages and snaps';

  @override
  String get notifyRequests => 'Friend requests';

  @override
  String get notifyCapsules => 'A capsule opened';

  @override
  String get notifyShadow => 'A friend left the shadow';

  @override
  String get notifyStreaks => 'A streak at risk';

  @override
  String get notifyAchievements => 'New achievement';

  @override
  String get notifyWeeklyReport => 'Weekly report';

  @override
  String get notificationsPreview => 'What notifications show';

  @override
  String get previewFull => 'Message text';

  @override
  String get previewSender => 'Only “New message from Anya”';

  @override
  String get previewNone => 'Only “New message”';

  @override
  String get notificationsQuietHours => 'Quiet hours';

  @override
  String get notificationsQuietHoursHint =>
      'Notifications wait and arrive in the morning as one summary';

  @override
  String notificationsQuietFromTo(String from, String to) {
    return 'From $from to $to';
  }

  @override
  String get notificationsSystem => 'Sound and vibration';

  @override
  String get notificationsSystemHint => 'Open system notification settings';

  @override
  String get settingsChatsMedia => 'Chats and media';

  @override
  String get chatsDefaultRetention => 'Messages in new chats';

  @override
  String get chatsDefaultRetentionHint =>
      'A chat takes the stricter of both rules; it can be changed in the chat';

  @override
  String get chatsMedia => 'Media';

  @override
  String get mediaAutoload => 'Auto-download photos and videos';

  @override
  String get mediaAlways => 'Always';

  @override
  String get mediaWifi => 'Wi-Fi only';

  @override
  String get mediaNever => 'Never';

  @override
  String get dataSaver => 'Data saver';

  @override
  String get dataSaverHint => 'Send photos and videos at a smaller size';

  @override
  String get clearCache => 'Clear cache';

  @override
  String cacheSize(String size) {
    return 'Cache: $size MB';
  }

  @override
  String get cacheCleared => 'Cache cleared';

  @override
  String get appearanceHaptics => 'Haptics';

  @override
  String get appearanceMotion => 'Animations';

  @override
  String get appearanceMotionSystem => 'Same as the system';

  @override
  String get appearanceMotionReduced => 'Always fewer';
}
