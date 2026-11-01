import 'dart:async';

import 'package:http/http.dart' as http;

/// HTTP-клиент для Supabase с лимитом ожидания ответа.
///
/// Без лимита запрос при плохой связи висит бесконечно и экран крутит
/// загрузку. С лимитом он падает с [TimeoutException], и экран показывает
/// ошибку с кнопкой «Повторить».
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
