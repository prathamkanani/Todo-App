import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/logic/chat/chat_cubit.dart';
import '../../../../application/logic/chat/chat_state.dart';
import '../../../../application/logic/chat_group/chat_group_cubit.dart';
import '../../../../application/logic/chat_group/chat_group_state.dart';
import '../../../../domain/entity/chat_entity.dart';
import '../../../../generated/l10n.dart';

class AskAnythingField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode chatFocusNode;
  final ChatCubit chatCubit;
  final ChatGroupCubit chatGroupCubit;
  final VoidCallback sendChat;

  const AskAnythingField({
    super.key,
    required this.controller,
    required this.chatFocusNode,
    required this.chatCubit,
    required this.chatGroupCubit,
    required this.sendChat,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    return TextFormField(
      focusNode: chatFocusNode,
      controller: controller,
      cursorColor: colorScheme.onSecondary,
      decoration: InputDecoration(
        filled: true,
        fillColor: colorScheme.surfaceContainer,
        // TODO: from theme
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        hintText: S.of(context).askAnything,
        suffixIcon: BlocListener(
          bloc: chatGroupCubit,
          listenWhen: (prev, next) {
            if (prev is ChatGroupNewState) return true;
            return false;
          },
          listener: (context, state) {
            if (state is ChatGroupNewState) {
              chatCubit.sendChat(
                ChatEntity(
                  chatGroupId: chatGroupCubit.randomId,
                  text: controller.text,
                  sentTime: DateTime.now(),
                  isSelf: true,
                  isSent: true,
                ),
              );
              controller.clear();
            }
          },
          child: BlocBuilder<ChatCubit, ChatState>(
            bloc: chatCubit,
            buildWhen: (prev, next) {
              return next is PromptState;
            },
            builder: (context, state) {
              if (state is PromptState && state.isLoading) {
                return Align(
                  alignment: AlignmentGeometry.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: colorScheme.onSecondary,
                      ),
                    ),
                  ),
                );
              }
              return IconButton(
                onPressed: () => sendChat(),
                icon: const Icon(Icons.send),
              );
            },
          ),
        ),
      ),
    );
  }
}
