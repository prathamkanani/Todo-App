import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/logic/chat/chat_cubit.dart';
import '../../../../application/logic/chat/chat_state.dart';
import '../../../../application/logic/chat_group/chat_group_cubit.dart';
import '../../../../domain/entity/chat_group_entity.dart';
import '../../../../infrastructure/extension/context_extension.dart';
import '../../../config/app_spacing.dart';

class ChatList extends StatelessWidget {
  final ChatCubit chatCubit;
  final ChatGroupCubit chatGroupCubit;

  const ChatList({
    super.key,
    required this.chatCubit,
    required this.chatGroupCubit,
  });

  void loadingChat(ChatGroupEntity chatGroup) {
    chatGroupCubit.createdGroup = true;
    chatCubit.fetchGroupedChats(chatGroup, (id) {
      chatGroupCubit.randomId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    return Expanded(
      child: BlocListener(
        bloc: chatCubit,
        listener: (context, state) {
          if (state is ChatLoadedState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.pop();
            });
          }
        },
        child: ListView.separated(
          itemCount: chatGroupCubit.chatGroups.length,
          itemBuilder: (context, final int index) {
            final ChatGroupEntity chat = chatGroupCubit.chatGroups[index];
            return Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainer.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(24),
              ),
              child: InkWell(
                onTap: () => loadingChat(chat),
                child: Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 12.0,
                    ),
                    child: Text(
                      chat.chatGroupTitle,
                      style: TextStyle(
                        color: colorScheme.onSurface,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (_, _) => AppSpacing.h08,
        ),
      ),
    );
  }
}
