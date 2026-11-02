/// Openers offered when a conversation has gone quiet. A fixed list for
/// now; later the server can personalise them.
List<String> conversationStarters(String friendName) => [
  'Привет, $friendName! Давно не болтали — как ты?',
  'Сегодня кое-что напомнило мне о тебе 👀',
  'Что было самым странным на этой неделе?',
  'Созвонимся на выходных?',
];
