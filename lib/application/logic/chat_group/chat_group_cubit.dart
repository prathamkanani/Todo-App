import 'package:bloc/bloc.dart';
import '../../../domain/entity/chat_group_entity.dart';
import '../../../domain/repository/chat_group_repository.dart';
import 'chat_group_state.dart';

class ChatGroupCubit extends Cubit<ChatGroupState> {
  final ChatGroupRepository chatGroupRepository;
  final List<ChatGroupEntity> chatGroups = [];
  int randomId = 0;
  bool createdGroup = false;

  ChatGroupCubit({required this.chatGroupRepository})
    : super(ChatGroupLoadingState());

  Future<void> loadAllChats() async {
    try {
      chatGroups.addAll(await chatGroupRepository.loadAllChats());
      emit(ChatGroupLoadedState(chatGroups: chatGroups));
    } catch (e) {
      emit(ChatGroupErrorState(error: e));
    }
  }

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

  Future<void> loadChat(ChatGroupEntity chatGroupEntity) async {
    try {
      chatGroups.add(await chatGroupRepository.loadChat(chatGroupEntity));
      emit(ChatGroupLoadedState(chatGroups: chatGroups));
    } catch (e) {
      emit(ChatGroupErrorState(error: e));
    }
  }
}
