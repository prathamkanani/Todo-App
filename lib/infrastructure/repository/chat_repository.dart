import '../../domain/entity/chat_entity.dart';
import '../../domain/entity/chat_group_entity.dart';
import '../../domain/repository/chat_repository.dart';
import '../source/chat_source.dart';

/// Concrete implementation of the [ChatRepository] repository.
///
/// * [source] : This is the source that is called by the repository.
class ChatRepositoryImpl implements ChatRepository {
  final ChatSource source;

  ChatRepositoryImpl({required this.source});

  @override
  Future<List<ChatEntity>> fetchChats() async {
    final List<ChatEntity> chats = await source.fetchChats();
    return chats;
  }

  @override
  Future<List<ChatEntity>> fetchGroupedChats(
    ChatGroupEntity chatGroupEntity,
  ) async {
    return await source.fetchGroupedChats(chatGroupEntity);
  }

  @override
  Future<ChatEntity> send(ChatEntity chat) async {
    final ChatEntity sentChat = await source.send(chat);
    return sentChat;
  }

  @override
  Future<void> delete(ChatEntity chat) async {
    await source.delete(chat);
  }

  @override
  Stream<ChatEntity> sendPrompt(String prompt) {
    return source.sendPrompt(prompt);
  }
}
