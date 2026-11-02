import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/features/chat/data/repositories/supabase_chat_repository.dart';
import 'package:orbitly/features/chat/domain/entities/message.dart';

/// Строки — в том виде, как их отдают get_thread и send_message.
void main() {
  Map<String, dynamic> row(String kind, {String? text, String? opensAt}) => {
    'id': '5b0c-$kind',
    'kind': kind,
    'is_mine': false,
    'sent_at': '2026-11-02T10:00:00+00:00',
    'text': text,
    'opens_at': opensAt,
    'opened': false,
  };

  test('text, sealed capsule and snap', () {
    final messages = messagesFromRpcRows([
      row('text', text: 'Привет!'),
      row('capsule', opensAt: '2026-11-05T10:00:00+00:00'),
      row('snap'),
    ]);

    expect(messages, hasLength(3));
    expect((messages[0] as TextMessage).text, 'Привет!');
    final capsule = messages[1] as CapsuleMessage;
    expect(capsule.text, isNull, reason: 'текст запечатанной капсулы скрыт');
    expect(capsule.opensAt, DateTime.utc(2026, 11, 5, 10));
    expect((messages[2] as SnapMessage).opened, isFalse);
  });

  test('a broken row is skipped instead of breaking the chat', () {
    final messages = messagesFromRpcRows([
      row('text', text: 'ok'),
      row('hologram'),
      {'kind': 'text'},
    ]);

    expect(messages, hasLength(1));
  });
}
