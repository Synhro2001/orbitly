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

  static String chat(String friendId) => '/chat/$friendId';
}
