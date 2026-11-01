abstract final class AppRoutes {
  static const splash = '/splash';
  static const onboarding = '/onboarding';
  static const system = '/system';
  static const chats = '/chats';
  static const planet = '/planet';
  static const camera = '/camera';
  static const report = '/report';
  static const friends = '/friends';

  static String chat(String friendId) => '/chat/$friendId';
}
