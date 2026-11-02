import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/features/settings/data/repositories/in_memory_settings_repository.dart';
import 'package:orbitly/features/settings/domain/entities/device_settings.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('DailyUsage', () {
    final morning = DateTime(2026, 11, 3, 9);

    test('counts minutes within a day and starts over the next day', () {
      var usage = const DailyUsage().addMinute(morning).addMinute(morning);
      expect(usage.minutes, 2);
      usage = usage.addMinute(morning.add(const Duration(days: 1)));
      expect((usage.day, usage.minutes), ('2026-11-04', 1));
    });

    test('reminds once the limit is reached, and only once a day', () {
      const usage = DailyUsage(day: '2026-11-03', minutes: 30);
      expect(usage.shouldRemind(limitMinutes: null), isFalse);
      expect(usage.shouldRemind(limitMinutes: 60), isFalse);
      expect(usage.shouldRemind(limitMinutes: 30), isTrue);
      expect(
        usage.copyWith(reminded: true).shouldRemind(limitMinutes: 30),
        isFalse,
      );
    });
  });

  for (final hidden in [false, true]) {
    testWidgets('streak counters ${hidden ? 'hidden' : 'shown'} when '
        '"streaks without pressure" is ${hidden ? 'on' : 'off'}', (
      tester,
    ) async {
      final store = MockStore(latency: Duration.zero, withPlanet: true)
        ..settings = {'hide_streaks': hidden};
      final router = await pumpApp(tester, store: store);
      router.go(AppRoutes.chats);
      await tester.pumpAndSettle();
      expect(find.textContaining('🔥'), hidden ? findsNothing : findsWidgets);
      expect(find.textContaining('🧊'), hidden ? findsNothing : findsWidgets);
    });
  }

  testWidgets('the soft limit reminds once, without locking anything', (
    tester,
  ) async {
    final settings = InMemorySettingsRepository()
      ..usage = DailyUsage(day: DailyUsage.dayOf(DateTime.now()), minutes: 14);
    final store = MockStore(latency: Duration.zero, withPlanet: true)
      ..settings = {'daily_limit_minutes': 15};
    await pumpApp(tester, store: store, settings: settings);

    await tester.pump(const Duration(minutes: 1));
    await tester.pump();
    expect(find.textContaining('уже 15 минут'), findsOneWidget);
    expect(settings.usage.reminded, isTrue);
    // Let the reminder go away by itself.
    await tester.pump(const Duration(seconds: 10));
    await tester.pumpAndSettle();
  });

  testWidgets('phone settings are saved on the phone', (tester) async {
    final settings = InMemorySettingsRepository();
    final router = await pumpApp(tester, settings: settings);
    router.go(AppRoutes.settingsAppearance);
    await tester.pumpAndSettle();

    await tester.tap(
      find.descendant(
        of: find.byKey(const Key('appearance-haptics')),
        matching: find.byType(Switch),
      ),
    );
    await tester.pumpAndSettle();
    expect(settings.device.haptics, isFalse);

    await tester.tap(find.byKey(const Key('appearance-motion')));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Всегда меньше'));
    await tester.pumpAndSettle();
    expect(settings.device.motion, MotionPreference.reduced);
  });
}
