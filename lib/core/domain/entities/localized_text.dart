import 'package:freezed_annotation/freezed_annotation.dart';

part 'localized_text.freezed.dart';

/// Server content in several languages, e.g.
/// `{"ru": "Аврора", "en": "Aurora"}`.
///
/// The server sends every language and the UI picks one, so switching the
/// app language needs no reload.
@freezed
abstract class LocalizedText with _$LocalizedText {
  const factory LocalizedText(Map<String, String> byLanguage) = _LocalizedText;

  const LocalizedText._();

  /// Used when a text has no version in the requested language. The server
  /// requires it for every catalogue row.
  static const fallbackLanguage = 'en';

  /// The text in [languageCode], else English, else any language there is.
  String inLanguage(String languageCode) =>
      byLanguage[languageCode] ??
      byLanguage[fallbackLanguage] ??
      byLanguage.values.firstOrNull ??
      '';
}
