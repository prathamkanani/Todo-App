import '../../../domain/entity/chat_entity.dart';

/// Base state for chat.
sealed class ChatState {}

/// Initial chat loading state.
final class ChatLoadingState extends ChatState {}

/// Home page state for showing home page.
final class ChatHomePageState extends ChatState {}

/// Prompt state where AI is responding.
///
/// * [isLoading] : To check whether the response is being generated or not.
final class PromptState extends ChatState {
  bool isLoading;
  PromptState({required this.isLoading});
}

/// Chat loaded state for showing all the chats.
///
/// * [chats] : The list of chats.
final class ChatLoadedState extends ChatState {
  final List<ChatEntity> chats;

  ChatLoadedState({required this.chats});
}

/// Chat loading error state for any error.
///
/// * [error] : The error that might have occurred.
final class ChatLoadingErrorState extends ChatState {
  final Object? error;

  ChatLoadingErrorState({required this.error});
}