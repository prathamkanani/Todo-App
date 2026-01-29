import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../../domain/entity/chat_entity.dart';
import '../../../domain/entity/chat_group_entity.dart';
import '../../../domain/repository/chat_repository.dart';
import 'chat_state.dart';

/// The [Cubit] responsible for the chat related operations.
class ChatCubit extends Cubit<ChatState> {
  /// The [ChatRepository] it needs as a dependency.
  final ChatRepository chatRepository;

  /// This is a temporary storage for chats.
  final List<ChatEntity> chats = [];

  /// To check whether a chat to be sent needs a new group or an existing group.
  int counter = 0;

  /// For storing the response of AI to pass it on to the [ChatEntity].
  String text = '';

  /// A stream subscriber that subscribes a stream of AI response.
  StreamSubscription<ChatEntity>? promptSubscriber;

  /// Constructor to create instance of [ChatCubit].
  ChatCubit({required this.chatRepository}) : super(ChatLoadingState());

  /// This emits the [ChatHomePage].
  Future<void> homeScreen() async {
    emit(ChatHomePageState());
  }

  /// This method fetches all the existing chats.
  Future<void> fetchChats() async {
    try {
      chats.addAll(await chatRepository.fetchChats());
      emit(ChatLoadedState(chats: chats));
    } catch (e) {
      emit(ChatLoadingErrorState(error: e));
    }
  }

  /// This method fetches all the grouped chats.
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

  /// This method sends a chat.
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

  /// This method deletes a chat.
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

  /// This method sends the prompt to the AI chatbot.
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

  /// This overrides the default cubit method to also cancel the subscriber.
  @override
  Future<void> close() {
    promptSubscriber?.cancel();
    return super.close();
  }
}
