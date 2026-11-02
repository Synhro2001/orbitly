import 'dart:async';

import 'package:http/http.dart' as http;

/// HTTP client for Supabase with a response time limit.
///
/// Without a limit, a request on a bad connection can hang forever and the
/// screen keeps spinning. With one, it fails with [TimeoutException] and the
/// screen shows an error with a "Retry" button.
class TimeoutClient extends http.BaseClient {
  TimeoutClient(this._inner, {this.timeout = const Duration(seconds: 15)});

  final http.Client _inner;
  final Duration timeout;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) =>
      _inner.send(request).timeout(timeout);

  @override
  void close() => _inner.close();
}
