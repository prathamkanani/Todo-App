import '../../../domain/entity/chat_group_entity.dart';

/// Base class for the [ChatGroupState].
sealed class ChatGroupState {}

/// Initial loading state for chat group.
final class ChatGroupLoadingState extends ChatGroupState {}

/// Creating a new group state.
///
/// * [title] : The title for a new chat group.
final class ChatGroupNewState extends ChatGroupState {
  String title;
  ChatGroupNewState({required this.title});
}

/// Loading all the existing chat groups.
///
/// * [chatGroups] : List of all the existing chat groups.
final class ChatGroupLoadedState extends ChatGroupState {
  final List<ChatGroupEntity> chatGroups;
  ChatGroupLoadedState({required this.chatGroups});
}

/// Error state for loading of chat group.
///
/// * [error] : The error that may have occurred.
final class ChatGroupErrorState extends ChatGroupState {
  final Object? error;
  ChatGroupErrorState({this.error});
}
