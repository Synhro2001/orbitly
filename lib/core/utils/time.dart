/// Сколько дней осталось до [until], с округлением вверх: «через 2 часа»
/// показываем как «через 1 день», а не «через 0».
int daysUntil(DateTime until, {required DateTime now}) {
  final minutes = until.difference(now).inMinutes;
  if (minutes <= 0) return 0;
  return (minutes / Duration.minutesPerDay).ceil();
}
