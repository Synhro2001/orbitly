import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:orbitly/core/domain/entities/localized_text.dart';

/// JSON ↔ [LocalizedText]. The server sends `{"ru": "...", "en": "..."}`.
/// A plain string (a server from before translations) is kept as a text in
/// an unknown language, so it still shows up instead of breaking the row.
class LocalizedTextConverter implements JsonConverter<LocalizedText, Object> {
  const LocalizedTextConverter();

  @override
  LocalizedText fromJson(Object json) => switch (json) {
    String() => LocalizedText({'': json}),
    Map() => LocalizedText({
      for (final MapEntry(:key, :value) in json.entries)
        if ((key, value) case (final String language, final String text))
          language: text,
    }),
    _ => throw FormatException('Not a translated text: $json'),
  };

  @override
  Object toJson(LocalizedText text) => text.byLanguage;
}
