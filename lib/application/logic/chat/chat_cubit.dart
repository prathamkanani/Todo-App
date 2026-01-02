import 'package:bloc/bloc.dart';
import '../../../domain/entity/chat_entity.dart';
import '../../../domain/repository/chat_repository.dart';
import 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository chatRepository;
  final List<ChatEntity> chats = [];

  ChatCubit({required this.chatRepository}) : super(ChatLoadingState());

  Future<void> fetchChats() async {
    try {
      chats.addAll(await chatRepository.fetchChats());
      emit(ChatLoadedState(chats: chats));
    } catch (e) {
      emit(ChatLoadingErrorState(error: e));
    }
  }

  Future<void> sendChat(ChatEntity chat) async {
    try {
      final ChatEntity sentChat = await chatRepository.send(chat);
      chats.add(sentChat);
    } catch (e) {
      chats.add(chat.failed(e));
    } finally {
      emit(ChatLoadedState(chats: chats));
    }
  }
}
