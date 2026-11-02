/// Days left until [until], rounded up: "in 2 hours" shows as "in 1 day",
/// not "in 0".
int daysUntil(DateTime until, {required DateTime now}) {
  final minutes = until.difference(now).inMinutes;
  if (minutes <= 0) return 0;
  return (minutes / Duration.minutesPerDay).ceil();
}
