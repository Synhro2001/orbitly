abstract final class FriendSearchRules {
  /// Ник не длиннее 32 символов — более длинный запрос ничего не найдёт,
  /// а серверу не нужно обрабатывать мусор.
  static const maxQueryLength = 32;
}
