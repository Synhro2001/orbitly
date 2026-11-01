import 'dart:convert';
import 'dart:io';

import 'package:integration_test/integration_test_driver.dart';

/// Сохраняет замеры кадров в build/perf.json.
Future<void> main() => integrationDriver(
  responseDataCallback: (data) async {
    if (data == null) return;
    await File('build/perf.json')
        .writeAsString(const JsonEncoder.withIndent('  ').convert(data));
  },
);
