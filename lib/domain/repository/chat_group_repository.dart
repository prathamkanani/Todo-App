import '../entity/chat_group_entity.dart';

abstract interface class ChatGroupRepository {
  Future<List<ChatGroupEntity>> loadAllChats();
  Future<ChatGroupEntity> createNewChatGroup(ChatGroupEntity chatGroupEntity);
  Future<ChatGroupEntity> loadChat(ChatGroupEntity chatGroupEntity);
}
