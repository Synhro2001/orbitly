import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:orbitly/core/data/network/timeout_client.dart';

void main() {
  test('a request that never answers fails instead of hanging', () async {
    final client = TimeoutClient(
      MockClient((_) => Completer<http.Response>().future),
      timeout: const Duration(milliseconds: 50),
    );

    await expectLater(
      client.get(Uri.parse('http://10.0.2.2:54321/rest/v1/profiles')),
      throwsA(isA<TimeoutException>()),
    );
  });

  test('a normal answer passes through', () async {
    final client = TimeoutClient(
      MockClient((_) async => http.Response('ok', 200)),
    );

    final response = await client.get(Uri.parse('http://localhost/'));

    expect(response.body, 'ok');
  });
}
