import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/core/domain/entities/localized_text.dart';

void main() {
  const text = LocalizedText({'ru': 'Аврора', 'en': 'Aurora'});

  test('picks the requested language', () {
    expect(text.inLanguage('ru'), 'Аврора');
    expect(text.inLanguage('en'), 'Aurora');
  });

  test('falls back to English for a language it does not have', () {
    expect(text.inLanguage('de'), 'Aurora');
  });

  test('without English, uses any language there is', () {
    expect(const LocalizedText({'ru': 'Аврора'}).inLanguage('de'), 'Аврора');
  });

  test('an empty text gives an empty string, not an error', () {
    expect(const LocalizedText({}).inLanguage('en'), '');
  });

  test('equal when the translations are equal', () {
    expect(
      const LocalizedText({'en': 'Aurora'}),
      equals(LocalizedText(Map.of({'en': 'Aurora'}))),
    );
  });
}
