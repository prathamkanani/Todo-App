import '../../domain/entity/chat_entity.dart';
import '../../domain/repository/chat_repository.dart';
import '../source/chat_source.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatSource source;

  ChatRepositoryImpl({required this.source});

  @override
  Future<List<ChatEntity>> fetchChats() async {
    final List<ChatEntity> chats = await source.fetchChats();
    return chats;
  }

  @override
  Future<ChatEntity> send(ChatEntity chat) async {
    final ChatEntity sentChat = await source.send(chat);
    return sentChat;
  }
}