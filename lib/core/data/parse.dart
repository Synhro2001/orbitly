/// Разбирает список с сервера, пропуская записи, которые не удалось
/// прочитать. Данные задают другие пользователи, и одна испорченная запись
/// не должна ломать весь экран.
List<T> parseValid<T>(
  Iterable<Map<String, Object?>> rows,
  T Function(Map<String, Object?> json) parse,
) => [for (final row in rows) ?_tryParse(row, parse)];

T? _tryParse<T>(
  Map<String, Object?> row,
  T Function(Map<String, Object?> json) parse,
) {
  try {
    return parse(row);
  } on Object {
    return null;
  }
}
