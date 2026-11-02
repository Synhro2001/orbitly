import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/features/settings/domain/app_language.dart';

void main() {
  const supported = {'ru', 'en'};

  group('resolveLanguage', () {
    test('takes the first phone language the app has', () {
      expect(resolveLanguage(['de', 'ru', 'en'], supported), 'ru');
    });

    test('falls back to English when the app has none of them', () {
      expect(resolveLanguage(['de', 'fr'], supported), 'en');
      expect(resolveLanguage([], supported), 'en');
    });
  });

  group('AppLanguage.fromCode', () {
    test('a stored code comes back as the same language', () {
      for (final language in AppLanguage.values) {
        expect(AppLanguage.fromCode(language.code), language);
      }
    });

    test('nothing stored or an unknown code means "same as the phone"', () {
      expect(AppLanguage.fromCode(null), AppLanguage.system);
      expect(AppLanguage.fromCode('xx'), AppLanguage.system);
    });
  });
}
