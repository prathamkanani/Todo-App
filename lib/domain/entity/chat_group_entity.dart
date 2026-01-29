/// Defines a ChatGroup in the application [ChatGroupEntity].
class ChatGroupEntity {
  /// The unique id for the chat group.
  final int? id;

  /// The title for a chat group.
  final String chatGroupTitle;

  /// The time of creation of the chat group.
  final DateTime createdAt;

  /// Constructor for creating instance of the [ChatGroupEntity].
  const ChatGroupEntity({
    this.id,
    required this.chatGroupTitle,
    required this.createdAt,
  });

  /// Method to assign a chat group with a unique id.
  ChatGroupEntity withId(int id) {
    return ChatGroupEntity(
      id: id,
      chatGroupTitle: chatGroupTitle,
      createdAt: createdAt,
    );
  }
}
