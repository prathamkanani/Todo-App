import 'package:bloc/bloc.dart';
import '../../../domain/entity/chat_group_entity.dart';
import '../../../domain/repository/chat_group_repository.dart';
import 'chat_group_state.dart';

/// The [Cubit] responsible for chat group related operations.
class ChatGroupCubit extends Cubit<ChatGroupState> {
  /// The [ChatGroupRepository] repository that is needed as a dependency.
  final ChatGroupRepository chatGroupRepository;

  /// A temporary list of all the chat groups.
  final List<ChatGroupEntity> chatGroups = [];

  /// A temporary group id.
  int randomId = 0;

  /// To check whether a group exists or not.
  bool createdGroup = false;

  /// Creating instance of [ChatGroupCubit].
  ChatGroupCubit({required this.chatGroupRepository})
    : super(ChatGroupLoadingState());

  /// This method load all the chats.
  Future<void> loadAllChats() async {
    try {
      chatGroups.addAll(await chatGroupRepository.loadAllChats());
      emit(ChatGroupLoadedState(chatGroups: chatGroups));
    } catch (e) {
      emit(ChatGroupErrorState(error: e));
    }
  }

  /// This method creates a new chat group.
  ///
  /// * [chatGroupEntity] : The chat with which a new chat group will be created.
  /// * [groupId] : The group id that will be generated after creating a new chat group.
  Future<void> createNewChatGroup(
    ChatGroupEntity chatGroupEntity,
    void Function(int) groupId,
  ) async {
    try {
      final chat = await chatGroupRepository.createNewChatGroup(
        chatGroupEntity,
      );
      randomId = chat.id!;
      groupId(chat.id!);
      chatGroups.add(chat);
      emit(ChatGroupNewState(title: chat.chatGroupTitle));
    } catch (e) {
      emit(ChatGroupErrorState(error: e));
    } finally {
      emit(ChatGroupLoadedState(chatGroups: chatGroups));
    }
  }

  /// The method to load all the chats inside a chat group.
  ///
  /// * [chatGroupEntity] : The chat group which is to be loaded.
  Future<void> loadChat(ChatGroupEntity chatGroupEntity) async {
    try {
      chatGroups.add(await chatGroupRepository.loadChat(chatGroupEntity));
      emit(ChatGroupLoadedState(chatGroups: chatGroups));
    } catch (e) {
      emit(ChatGroupErrorState(error: e));
    }
  }
}
