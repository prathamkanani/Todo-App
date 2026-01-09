import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../domain/entity/chat_entity.dart';
import '../../../domain/entity/chat_group_entity.dart';
import '../../../domain/repository/chat_repository.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository chatRepository;
  final List<ChatEntity> chats = [];
  int counter = 0;
  String text = '';

  StreamSubscription<ChatEntity>? promptSubscriber;

  ChatCubit({required this.chatRepository}) : super(ChatLoadingState());

  Future<void> homeScreen() async {
    emit(ChatHomePageState());
  }

  Future<void> fetchChats() async {
    try {
      chats.addAll(await chatRepository.fetchChats());
      emit(ChatLoadedState(chats: chats));
    } catch (e) {
      emit(ChatLoadingErrorState(error: e));
    }
  }

  Future<void> fetchGroupedChats(
    ChatGroupEntity chatGroupEntity,
    void Function(int) groupId,
  ) async {
    try {
      chats.clear();
      groupId(chatGroupEntity.id!);
      chats.addAll(await chatRepository.fetchGroupedChats(chatGroupEntity));
      emit(ChatLoadedState(chats: chats));
    } catch (e) {
      emit(ChatLoadingErrorState(error: e));
    }
  }

  Future<void> sendChat(ChatEntity chat) async {
    try {
      final ChatEntity sentChat = await chatRepository.send(chat);
      chats.add(sentChat);
      sentPrompt(chat.text);
    } catch (e) {
      chats.add(chat.failed(e));
    } finally {
      emit(ChatLoadedState(chats: chats));
    }
  }

  Future<void> deleteChat(ChatEntity chat, int index) async {
    try {
      await chatRepository.delete(chat);
    } catch (e) {
      chat.failedToDelete();
    } finally {
      chats.removeAt(index);
      emit(ChatLoadedState(chats: chats));
    }
  }

  Future<void> sentPrompt(String prompt) async {
    emit(PromptState(isLoading: true));
    promptSubscriber = chatRepository.sendPrompt(prompt).listen(null);
    promptSubscriber?.onData((final ChatEntity chat) {
      text += chat.text;
      if (counter == 0) {
        chats.add(chat);
      } else {
        chats.removeLast();
        chats.add(ChatEntity.promptResponse(text));
      }
      counter++;
      emit(ChatLoadedState(chats: chats));
    });
    promptSubscriber?.onDone(() {
      final int groupId = chats[chats.length - 2].chatGroupId!;
      chatRepository.send(ChatEntity.groupId(chats.last, groupId));
      text = '';
      counter = 0;
      emit(PromptState(isLoading: false));
    });
  }

  @override
  Future<void> close() {
    promptSubscriber?.cancel();
    return super.close();
  }
}
