import '../../domain/entity/chat_group_entity.dart';
import '../../domain/repository/chat_group_repository.dart';
import '../source/chat_group_source.dart';

class ChatGroupRepositoryImpl implements ChatGroupRepository {
  final ChatGroupSource chatGroupSource;

  ChatGroupRepositoryImpl({required this.chatGroupSource});

  @override
  Future<List<ChatGroupEntity>> loadAllChats() async {
    return await chatGroupSource.loadAllChats();
  }

  @override
  Future<ChatGroupEntity> loadChat(
    ChatGroupEntity chatGroupEntity,
  ) async {
    return await chatGroupSource.loadChat(chatGroupEntity);
  }

  @override
  Future<ChatGroupEntity> createNewChatGroup(
    ChatGroupEntity chatGroupEntity,
  ) async {
    return await chatGroupSource.createNewChatGroup(chatGroupEntity);
  }
}
