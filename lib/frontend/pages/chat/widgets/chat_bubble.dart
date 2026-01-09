import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:markdown_widget/widget/markdown.dart';
import '../../../../application/logic/chat/chat_cubit.dart';
import '../../../../domain/entity/chat_entity.dart';
import '../../../../generated/l10n.dart';
import '../../../../infrastructure/extension/context_extension.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.chat,
    required this.chatCubit,
    required this.index,
  });

  final int index;
  final ChatEntity chat;
  final ChatCubit chatCubit;

  void deleteAChat(BuildContext context) {
    chatCubit.deleteChat(chat, index);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    return Align(
      alignment: chat.isSelf
          ? AlignmentGeometry.centerRight
          : AlignmentGeometry.centerLeft,
      child: CupertinoContextMenu(
        actions: <Widget>[
          CupertinoContextMenuAction(
            onPressed: () => deleteAChat(context),
            trailingIcon: Icons.delete,
            child: Text(S.of(context).delete),
          ),
        ],
        child: Material(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: chat.isSelf
                  ? MediaQuery.sizeOf(context).width * 0.7
                  : MediaQuery.sizeOf(context).width,
            ),
            decoration: chat.isSelf
                ? BoxDecoration(
                    color: colorScheme.surfaceContainer.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(16),
                  )
                : null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: chat.isSelf
                  ? Text(
                      chat.text,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.visible,
                        color: colorScheme.onSecondary,
                      ),
                    )
                  : MarkdownWidget(data: chat.text, shrinkWrap: true),
            ),
          ),
        ),
      ),
    );
  }
}
