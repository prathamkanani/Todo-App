import '../../domain/entity/chat_entity.dart';

class ChatModel extends ChatEntity {
  ChatModel({
    super.id,
    super.chatGroupId,
    required super.text,
    required super.sentTime,
    required super.isSelf,
    required super.isSent,
  });

  factory ChatModel.fromEntity(ChatEntity chatEntity) {
    return ChatModel(
      id: chatEntity.id,
      chatGroupId: chatEntity.chatGroupId,
      text: chatEntity.text,
      sentTime: chatEntity.sentTime,
      isSelf: chatEntity.isSelf,
      isSent: chatEntity.isSent,
    );
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      chatGroupId: json['chat_group_id'],
      text: json['message'],
      sentTime: DateTime.parse(json['sent_time']),
      isSelf: 0 == json['is_self'] ? false : true,
      isSent: 0 == json['is_sent'] ? false : true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chat_group_id': chatGroupId,
      'message': text,
      'sent_time': sentTime.toString(),
      'is_self': isSelf ? 1 : 0,
      'is_sent': isSent ? 1 : 0,
    };
  }
}
