import '../entity/chat_group_entity.dart';

/// Defines the contracts of chat group.
abstract interface class ChatGroupRepository {
  /// For listing all the chat groups that exists.
  Future<List<ChatGroupEntity>> loadAllChats();

  /// For creating a new chat group.
  Future<ChatGroupEntity> createNewChatGroup(ChatGroupEntity chatGroupEntity);

  /// For loading a chat group with many [ChatEntity].
  Future<ChatGroupEntity> loadChat(ChatGroupEntity chatGroupEntity);
}
