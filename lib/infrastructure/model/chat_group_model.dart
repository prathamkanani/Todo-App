import '../../domain/entity/chat_group_entity.dart';

class ChatGroupModel extends ChatGroupEntity {
  ChatGroupModel({super.id, required super.chatGroupTitle, required super.createdAt});

  factory ChatGroupModel.fromEntity(ChatGroupEntity chatGroupEntity) {
    return ChatGroupModel(
      chatGroupTitle: chatGroupEntity.chatGroupTitle,
      createdAt: chatGroupEntity.createdAt,
    );
  }

  factory ChatGroupModel.fromJson(Map<String, dynamic> json) {
    return ChatGroupModel(
      id: json['id'],
      chatGroupTitle: json['chat_title'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chat_title': chatGroupTitle,
      'created_at': createdAt.toString()
    };
  }
}
