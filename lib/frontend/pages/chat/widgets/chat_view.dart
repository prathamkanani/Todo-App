import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/logic/chat/chat_cubit.dart';
import '../../../../application/logic/chat/chat_state.dart';
import '../../../../application/logic/chat_group/chat_group_cubit.dart';
import '../../../../domain/entity/chat_entity.dart';
import '../../../../generated/l10n.dart';
import '../../../config/app_spacing.dart';
import 'chat_bubble.dart';
import 'chat_home_screen.dart';

class ChatView extends StatelessWidget {
  const ChatView({
    super.key,
    required this.chatCubit,
    required this.chatGroupCubit,
    required this.controller,
    required this.chats,
  });

  final ChatCubit chatCubit;
  final ChatGroupCubit chatGroupCubit;
  final TextEditingController controller;
  final List<ChatEntity> chats;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ChatCubit, ChatState>(
        bloc: chatCubit,
        buildWhen: (prev, next) {
          return next is !PromptState;
        },
        builder: (context, state) {
          return switch (state) {
            ChatLoadingState() => const Center(
              child: CircularProgressIndicator(),
            ),
            ChatHomePageState() => ChatHomeScreen(
              chatCubit: chatCubit,
              chatGroupCubit: chatGroupCubit,
              controller: controller,
            ),
            ChatLoadedState() => ListView.separated(
              reverse: true,
              separatorBuilder: (_, _) => AppSpacing.h16,
              itemBuilder: (context, final int i) {
                final int index = chats.length - i - 1;
                final ChatEntity chat = chats[index];
                return ChatBubble(
                  index: index,
                  chat: chat,
                  chatCubit: chatCubit,
                );
              },
              itemCount: chats.length,
            ),
            ChatLoadingErrorState() => Center(
              child: Text(S.of(context).loadingChatFailed),
            ),
            PromptState() => const SizedBox.shrink(),
          };
        },
      ),
    );
  }
}