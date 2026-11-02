/// Parses a list from the server and skips rows that cannot be read. Other
/// users produce this data, and one broken row must not break the screen.
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
