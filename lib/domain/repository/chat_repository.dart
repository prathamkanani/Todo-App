import '../entity/chat_entity.dart';
import '../entity/chat_group_entity.dart';

/// Defines the contracts for the chat [ChatEntity].
abstract interface class ChatRepository {
  /// Lists all the chats.
  Future<List<ChatEntity>> fetchChats();

  /// Lists all the chats present in a group.
  Future<List<ChatEntity>> fetchGroupedChats(ChatGroupEntity chatGroupEntity);

  /// To send a chat.
  Future<ChatEntity> send(ChatEntity chat);

  /// This sends a prompt to the AI chatbot.
  Stream<ChatEntity> sendPrompt(String prompt);

  /// This allows user to delete a chat.
  Future<void> delete(ChatEntity chat);
}