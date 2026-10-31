import 'package:flutter_test/flutter_test.dart';
import 'package:orbitly/features/chat/domain/entities/message.dart';

void main() {
  final opensAt = DateTime(2026, 11, 7, 12);
  final capsule = Message.capsule(
    id: 'c',
    isMine: false,
    sentAt: DateTime(2026, 11),
    opensAt: opensAt,
    text: 'Привет из прошлого',
  ) as CapsuleMessage;

  test('capsule is sealed before its date', () {
    expect(
      capsule.isOpenAt(opensAt.subtract(const Duration(seconds: 1))),
      isFalse,
    );
  });

  test('capsule opens exactly at its date and stays open', () {
    expect(capsule.isOpenAt(opensAt), isTrue);
    expect(capsule.isOpenAt(opensAt.add(const Duration(days: 300))), isTrue);
  });
}
