import '../../../domain/entity/chat_entity.dart';

sealed class ChatState {}

final class ChatLoadingState extends ChatState {}

final class ChatHomePageState extends ChatState {}

final class PromptState extends ChatState {
  bool isLoading;
  PromptState({required this.isLoading});
}

final class ChatLoadedState extends ChatState {
  final List<ChatEntity> chats;

  ChatLoadedState({required this.chats});
}

final class ChatLoadingErrorState extends ChatState {
  final Object? error;

  ChatLoadingErrorState({required this.error});
}