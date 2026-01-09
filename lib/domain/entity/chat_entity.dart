/// Defines a chat in the application [ChatEntity].
class ChatEntity {
  final int? id;

  final int? chatGroupId;

  final String text;

  final DateTime sentTime;

  final bool isSelf;

  final bool isSent;

  final bool didDelete;

  final Object? error;

  const ChatEntity({
    this.id,
    this.chatGroupId,
    required this.text,
    required this.sentTime,
    required this.isSelf,
    required this.isSent,
    this.didDelete = true,
    this.error,
  });

  factory ChatEntity.promptResponse(String response) {
    return ChatEntity(
      text: response,
      sentTime: DateTime.now(),
      isSelf: false,
      isSent: true,
    );
  }

  factory ChatEntity.groupId(ChatEntity chat, int groupId) {
    return ChatEntity(
      chatGroupId: groupId,
      text: chat.text,
      sentTime: chat.sentTime,
      isSelf: chat.isSelf,
      isSent: chat.isSent,
    );
  }

  ChatEntity sent(int id) {
    return ChatEntity(
      chatGroupId: id,
      text: text,
      sentTime: sentTime,
      isSelf: isSelf,
      isSent: true,
    );
  }

  /// Failed method.
  ///
  /// * [error] : The error occurred.
  ChatEntity failed(Object error) {
    return ChatEntity(
      text: text,
      sentTime: sentTime,
      isSelf: isSelf,
      isSent: false,
      error: error,
    );
  }

  ChatEntity failedToDelete() {
    return ChatEntity(
      text: text,
      sentTime: sentTime,
      isSelf: isSelf,
      isSent: false,
      error: error,
      didDelete: false,
    );
  }
}
