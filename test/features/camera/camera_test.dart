import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/app/routes.dart';
import 'package:orbitly/core/data/mock/mock_store.dart';
import 'package:orbitly/core/data/models/award_model.dart';
import 'package:orbitly/core/domain/entities/award.dart';
import 'package:orbitly/core/domain/entities/cosmetic.dart';
import 'package:orbitly/core/domain/entities/localized_text.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/core/domain/usecases/apply_cosmetics.dart';
import 'package:orbitly/core/planet_render/planet_painter.dart';
import 'package:orbitly/features/camera/data/repositories/mock_capture_repository.dart';
import 'package:orbitly/features/camera/presentation/controllers/camera_providers.dart';

import '../../helpers/pump_app.dart';

void main() {
  group('"First shot" in demo mode', () {
    test('the first photo unlocks it and grants the "Lens" moon', () async {
      final store = MockStore(latency: Duration.zero);
      final unlocks = <String>[];
      store.unlocks.stream.listen(unlocks.add);

      await MockCaptureRepository(store).recordCapture();
      await Future<void>.delayed(Duration.zero);

      final row = store.achievements.firstWhere((a) => a['id'] == 'first_shot');
      expect(row['unlocked_at'], isNotNull);
      expect(store.owned, contains('moon_lens'));
      expect(unlocks, ['first_shot']);
    });

    test('later photos do not unlock it again', () async {
      final store = MockStore(latency: Duration.zero);
      final unlocks = <String>[];
      store.unlocks.stream.listen(unlocks.add);

      final repository = MockCaptureRepository(store);
      await repository.recordCapture();
      await repository.recordCapture();
      await Future<void>.delayed(Duration.zero);

      expect(store.photosTaken, 2);
      expect(unlocks, ['first_shot']);
    });
  });

  test('the server\'s "photo" category is read as AwardCategory.photo', () {
    final award = AwardModel.fromJson(const {
      'id': 'first_shot',
      'category': 'photo',
    }).toEntity();
    expect(award.category, AwardCategory.photo);
  });

  test('the "Lens" moon: skin from params, and it can be painted', () {
    const base = PlanetAppearance(type: PlanetType.ocean, seed: 7, hue: 200);
    final appearance = const ApplyCosmetics()(base, [
      const Cosmetic(
        id: 'moon_lens',
        title: LocalizedText({'en': 'Lens'}),
        kind: CosmeticKind.moon,
        rarity: Rarity.common,
        params: {'moons': 1, 'skin': 'lens'},
      ),
    ]);
    expect(appearance.moonSkin, MoonSkin.lens);
    expect(appearance.moons, 1);

    final recorder = ui.PictureRecorder();
    PlanetPainter(appearance).paint(Canvas(recorder), const Size.square(200));
    expect(recorder.endRecording, returnsNormally);
  });

  testWidgets('no camera on the device: says so and still closes', (
    tester,
  ) async {
    final router = await pumpApp(
      tester,
      overrides: [deviceCamerasProvider.overrideWith((ref) async => const [])],
    );
    unawaited(router.push(AppRoutes.camera));
    await tester.pumpAndSettle();

    expect(find.text('Камера недоступна на этом устройстве'), findsOneWidget);
    expect(find.bySemanticsLabel('Снять'), findsNothing);

    await tester.tap(find.byTooltip('Закрыть'));
    await tester.pumpAndSettle();
    expect(find.text('Камера недоступна на этом устройстве'), findsNothing);
  });
}
