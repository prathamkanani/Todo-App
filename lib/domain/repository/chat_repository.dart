import '../entity/chat_entity.dart';

abstract interface class ChatRepository {
  Future<List<ChatEntity>> fetchChats();
  Future<ChatEntity> send(ChatEntity chat);
}