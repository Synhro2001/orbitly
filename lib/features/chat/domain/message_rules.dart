/// Ограничения на сообщения. Клиент не даёт их нарушить, сервер проверяет
/// ещё раз — клиент можно подделать.
abstract final class MessageRules {
  /// Защита от гигантских сообщений, которые раздувают базу и вешают
  /// экран у получателя.
  static const maxLength = 1000;

  /// Капсулу нельзя отправить дальше, чем на год вперёд.
  static const maxCapsuleDelay = Duration(days: 366);

  static bool isValid(String text) {
    final trimmed = text.trim();
    return trimmed.isNotEmpty && trimmed.length <= maxLength;
  }

  static bool isValidCapsuleDate(DateTime opensAt, {required DateTime now}) =>
      opensAt.isAfter(now) && !opensAt.isAfter(now.add(maxCapsuleDelay));
}
