import '../entity/chat_entity.dart';
import '../entity/chat_group_entity.dart';

abstract interface class ChatRepository {
  Future<List<ChatEntity>> fetchChats();
  Future<List<ChatEntity>> fetchGroupedChats(ChatGroupEntity chatGroupEntity);
  Future<ChatEntity> send(ChatEntity chat);
  Stream<ChatEntity> sendPrompt(String prompt);
  Future<void> edit(ChatEntity chat);
  Future<void> delete(ChatEntity chat);
  Future<void> clearChat();
}