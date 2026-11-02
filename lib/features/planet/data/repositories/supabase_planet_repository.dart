import 'package:orbitly/core/data/models/cosmetic_model.dart';
import 'package:orbitly/core/data/parse.dart';
import 'package:orbitly/core/domain/entities/mood.dart';
import 'package:orbitly/core/domain/entities/planet_appearance.dart';
import 'package:orbitly/features/planet/data/models/my_planet_model.dart';
import 'package:orbitly/features/planet/domain/entities/my_planet.dart';
import 'package:orbitly/features/planet/domain/repositories/planet_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabasePlanetRepository implements PlanetRepository {
  const SupabasePlanetRepository(this._client);

  final SupabaseClient _client;

  String get _userId => _client.auth.currentUser!.id;

  @override
  Future<bool> hasPlanet() async {
    if (_client.auth.currentUser == null) return false;
    final row = await _client
        .from('profiles')
        .select('id')
        .eq('id', _userId)
        .maybeSingle();
    return row != null;
  }

  @override
  Future<MyPlanet> getMyPlanet() async {
    final (profile, equipped) = await (
      _client.from('profiles').select().eq('id', _userId).single(),
      _client
          .from('user_cosmetics')
          .select('equipped, cosmetics(*)')
          .eq('user_id', _userId)
          .eq('equipped', true),
    ).wait;
    return MyPlanetModel.fromJson(profile).toEntity(
      equipped: [
        for (final row in parseValid([
          for (final row in equipped)
            if (row['cosmetics'] case final Map<String, dynamic> c)
              {...c, 'equipped': true},
        ], CosmeticModel.fromJson))
          ?row.toEntity(),
      ],
    );
  }

  /// The server generates the handle; from the look it takes only type, seed
  /// and hue.
  @override
  Future<void> createPlanet({
    required String displayName,
    required String name,
    required PlanetAppearance appearance,
  }) => _client.rpc<void>(
    'complete_onboarding',
    params: {
      'p_display_name': displayName,
      'p_planet_name': name,
      'p_appearance': {
        'type': appearance.type.name,
        'seed': appearance.seed,
        'hue': appearance.hue,
      },
    },
  );

  @override
  Future<void> setMood(Mood mood) =>
      _client.from('profiles').update({'mood': mood.name}).eq('id', _userId);

  @override
  Future<void> enterShadow(Duration duration) =>
      _client.rpc<void>('set_shadow', params: {'p_days': duration.inDays});

  @override
  Future<void> leaveShadow() => _client.rpc<void>('leave_shadow');
}
