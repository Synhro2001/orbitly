import 'package:orbitly/core/domain/entities/shadow.dart';

/// A shadow comes from the server as two nullable fields (`shadow_from`,
/// `shadow_until`); it exists only when both are set.
Shadow? shadowFromFields(DateTime? from, DateTime? until) =>
    from != null && until != null ? Shadow(from: from, until: until) : null;
