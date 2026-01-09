import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/logic/chat/chat_cubit.dart';
import '../../../../application/logic/chat_group/chat_group_cubit.dart';
import '../../../../application/logic/chat_group/chat_group_state.dart';
import '../../../../domain/entity/chat_entity.dart';
import '../../../../domain/entity/chat_group_entity.dart';
import '../../../../generated/l10n.dart';
import '../../../config/app_spacing.dart';
import '../../../shared/base_page.dart';
import 'chat_initial_chip.dart';

class ChatHomeScreen extends StatelessWidget {
  final ChatCubit chatCubit;
  final ChatGroupCubit chatGroupCubit;
  final TextEditingController controller;

  const ChatHomeScreen({
    super.key,
    required this.controller,
    required this.chatCubit,
    required this.chatGroupCubit,
  });

  void createNewChatGroup(String title) {
    chatGroupCubit.createNewChatGroup(
      ChatGroupEntity(chatGroupTitle: title, createdAt: DateTime.now()),
      (id) {
        chatGroupCubit.randomId = id;
      },
    );
    chatGroupCubit.createdGroup = true;
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);
    return BasePage(
      bgColorNeeded: false,
      padding: EdgeInsets.zero,
      child: BlocListener(
        bloc: chatGroupCubit,
        listenWhen: (prev, next) {
          if (prev is ChatGroupLoadedState) {
            return true;
          }
          return false;
        },
        listener: (context, state) {
          if (state is ChatGroupNewState) {
            chatCubit.chats.clear();
            chatCubit.sendChat(
              ChatEntity(
                chatGroupId: chatGroupCubit.randomId,
                text: state.title,
                sentTime: DateTime.now(),
                isSelf: true,
                isSent: true,
              ),
            );
            controller.clear();
          }
        },
        child: Column(
          children: <Widget>[
            Text(
              S.of(context).helloUserTryOurVeryOwnAi,
              style: textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            AppSpacing.h48,
            ChatInitialChip(
              chipTitle: S.of(context).createATask,
              chatCubit: chatCubit,
              chatGroupCubit: chatGroupCubit,
              onTap: () {
                createNewChatGroup(S.of(context).createATask);
              },
            ),
            AppSpacing.h16,
            ChatInitialChip(
              chipTitle: S.of(context).giveAnIdea,
              chatCubit: chatCubit,
              chatGroupCubit: chatGroupCubit,
              onTap: () => createNewChatGroup(S.of(context).giveAnIdea),
            ),
            AppSpacing.h16,
            ChatInitialChip(
              chipTitle: S.of(context).deepResearch,
              chatCubit: chatCubit,
              chatGroupCubit: chatGroupCubit,
              onTap: () => createNewChatGroup(S.of(context).deepResearch),
            ),
          ],
        ),
      ),
    );
  }
}
