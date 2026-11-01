import 'package:orbitly/core/domain/entities/shadow.dart';

/// Тень приходит с сервера двумя nullable-полями (`shadow_from`,
/// `shadow_until`); она есть, только если заданы оба.
Shadow? shadowFromFields(DateTime? from, DateTime? until) =>
    from != null && until != null ? Shadow(from: from, until: until) : null;
