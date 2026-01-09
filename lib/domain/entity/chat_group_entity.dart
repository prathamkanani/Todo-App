class ChatGroupEntity {
  final int? id;

  final String chatGroupTitle;

  final DateTime createdAt;

  ChatGroupEntity({
    this.id,
    required this.chatGroupTitle,
    required this.createdAt,
  });

  ChatGroupEntity withId(int id) {
    return ChatGroupEntity(
      id: id,
      chatGroupTitle: chatGroupTitle,
      createdAt: createdAt,
    );
  }
}
