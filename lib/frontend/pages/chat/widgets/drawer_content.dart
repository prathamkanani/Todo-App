import 'package:flutter/material.dart';
import '../../../../application/logic/chat/chat_cubit.dart';
import '../../../../application/logic/chat_group/chat_group_cubit.dart';
import '../../../../generated/l10n.dart';
import '../../../../infrastructure/extension/context_extension.dart';
import '../../../config/app_spacing.dart';
import 'chat_list.dart';

class DrawerContent extends StatelessWidget {
  final ChatCubit chatCubit;
  final ChatGroupCubit chatGroupCubit;

  const DrawerContent({
    super.key,
    required this.chatCubit,
    required this.chatGroupCubit,
  });

  void newChat(BuildContext context) {
    context.pop();
    chatGroupCubit.createdGroup = false;
    chatCubit.homeScreen();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);
    final bool isChatPresent = chatGroupCubit.chatGroups.isNotEmpty;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () => newChat(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    const Icon(Icons.edit_note, size: 30),
                    AppSpacing.w08,
                    Text(
                      S.of(context).newChat,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppSpacing.h24,
            Text(
              S.of(context).chats,
              style: textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            AppSpacing.h16,
            ?isChatPresent
                ? ChatList(chatCubit: chatCubit, chatGroupCubit: chatGroupCubit)
                : null,
          ],
        ),
      ),
    );
  }
}
