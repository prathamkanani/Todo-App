import '../../../domain/entity/chat_group_entity.dart';

sealed class ChatGroupState {}

final class ChatGroupLoadingState extends ChatGroupState {}

final class ChatGroupNewState extends ChatGroupState {
  String title;
  ChatGroupNewState({required this.title});
}

final class ChatGroupLoadedState extends ChatGroupState {
  final List<ChatGroupEntity> chatGroups;
  ChatGroupLoadedState({required this.chatGroups});
}

final class ChatGroupErrorState extends ChatGroupState {
  final Object? error;
  ChatGroupErrorState({this.error});
}
