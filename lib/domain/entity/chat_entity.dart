class ChatEntity {
  final String text;

  final DateTime sentTime;

  final bool isSelf;

  final bool isSent;

  final Object? error;

  const ChatEntity({
    required this.text,
    required this.sentTime,
    required this.isSelf,
    required this.isSent,
    this.error,
  });

  ChatEntity sent() {
    return ChatEntity(
      text: text,
      sentTime: sentTime,
      isSelf: isSelf,
      isSent: true,
    );
  }

  ChatEntity failed(Object error) {
    return ChatEntity(
      text: text,
      sentTime: sentTime,
      isSelf: isSelf,
      isSent: false,
      error: error
    );
  }
}
