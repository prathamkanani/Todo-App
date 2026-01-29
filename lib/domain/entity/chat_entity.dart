/// Defines a chat in the application [ChatEntity].
class ChatEntity {
  /// Unique chat id.
  final int? id;

  /// To know which chat belongs to which group.
  final int? chatGroupId;

  /// The chat message itself.
  final String text;

  /// The time chat message was sent.
  final DateTime sentTime;

  /// To check who sent the chat.
  final bool isSelf;

  /// To check the message was sent successfully or not.
  final bool isSent;

  /// To check whether the chat was deleted or not.
  final bool didDelete;

  /// Get the error, if any.
  final Object? error;

  /// Constructor for creating instance of [ChatEntity].
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

  /// For creating the [ChatEntity] with a response from AI ChatBot.
  factory ChatEntity.promptResponse(String response) {
    return ChatEntity(
      text: response,
      sentTime: DateTime.now(),
      isSelf: false,
      isSent: true,
    );
  }

  /// For adding the [ChatEntity] to a chat group.
  ///
  /// * [chat] : The chat entity to be added to the group.
  /// * [groupId] : The group id that chat should be added to.
  factory ChatEntity.groupId(ChatEntity chat, int groupId) {
    return ChatEntity(
      chatGroupId: groupId,
      text: chat.text,
      sentTime: chat.sentTime,
      isSelf: chat.isSelf,
      isSent: chat.isSent,
    );
  }

  /// Sent method.
  ///
  /// * [id] : The chat group id this chat belongs to.
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

  /// Failed to delete method.
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
