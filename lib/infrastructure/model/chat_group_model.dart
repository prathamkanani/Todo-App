import '../../domain/entity/chat_group_entity.dart';

/// Description: Chat group model for data transfer.
class ChatGroupModel extends ChatGroupEntity {
  ChatGroupModel({
    super.id,
    required super.chatGroupTitle,
    required super.createdAt,
  });

  /// This converts from [ChatGroupEntity] to [ChatGroupModel].
  factory ChatGroupModel.fromEntity(ChatGroupEntity chatGroupEntity) {
    return ChatGroupModel(
      chatGroupTitle: chatGroupEntity.chatGroupTitle,
      createdAt: chatGroupEntity.createdAt,
    );
  }

  /// This converts the data received from database to [ChatGroupModel]
  /// For showing the received data in the UI.
  factory ChatGroupModel.fromJson(Map<String, dynamic> json) {
    return ChatGroupModel(
      id: json['id'],
      chatGroupTitle: json['chat_title'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  /// This method is for storing the data to the database in the correct format.
  Map<String, dynamic> toJson() {
    return {'chat_title': chatGroupTitle, 'created_at': createdAt.toString()};
  }
}
