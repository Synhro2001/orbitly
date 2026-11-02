abstract final class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const collection = '/collection';
  static const wardrobe = '/wardrobe';
  static const onboarding = '/onboarding';
  static const system = '/system';
  static const chats = '/chats';
  static const planet = '/planet';
  static const camera = '/camera';
  static const report = '/report';
  static const friends = '/friends';
  static const settings = '/settings';
  static const settingsAppearance = '/settings/appearance';
  static const settingsProfile = '/settings/profile';
  static const settingsAccount = '/settings/account';
  static const settingsDeleteAccount = '/settings/account/delete';

  /// The same deletion screen in the web build, for the store listing.
  static const deleteAccount = '/delete-account';
  static const settingsNotifications = '/settings/notifications';
  static const settingsWellbeing = '/settings/wellbeing';
  static const settingsChatsMedia = '/settings/chats';
  static const settingsHelp = '/settings/help';
  static const settingsPrivacy = '/settings/privacy';
  static const settingsBlocked = '/settings/privacy/blocked';
  static const settingsQuietOrbit = '/settings/privacy/quiet';

  static String chat(String friendId) => '/chat/$friendId';
  static String invite(String code) => '/invite/$code';
}
