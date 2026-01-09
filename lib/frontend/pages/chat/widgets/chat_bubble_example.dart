import 'package:flutter/material.dart';
import '../../../../application/logic/chat/chat_cubit.dart';
import '../../../../domain/entity/chat_entity.dart';

class ChatBubbleExample extends StatefulWidget {
  const ChatBubbleExample({
    super.key,
    required this.idx,
    required this.chat,
    required this.chatCubit,
  });

  final int idx;
  final ChatEntity chat;
  final ChatCubit chatCubit;

  @override
  State<ChatBubbleExample> createState() => _ChatBubbleExampleState();
}

class _ChatBubbleExampleState extends State<ChatBubbleExample> {
  Offset? _chatBubbleOffset;

  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback
    // This ensures that widget is completely built
    // and only then getting its size, offset, etc...
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = context.findRenderObject() as RenderBox;
      // Local to global converts from local coordinates
      // to global coordinates for a widget.
      _chatBubbleOffset = renderBox.localToGlobal(Offset.zero);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    return Align(
      alignment: AlignmentGeometry.centerRight,
      child: GestureDetector(
        onLongPress: () => {
          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
              _chatBubbleOffset?.dx ?? 0,
              _chatBubbleOffset?.dy ?? 0,
              0,
              0,
            ),
            items: <PopupMenuEntry>[
              PopupMenuItem(
                onTap: () {
                  widget.chatCubit.deleteChat(widget.chat, widget.idx);
                },
                child: const Icon(Icons.delete),
              ),
            ],
          ),
        },
        child: Container(
          decoration: BoxDecoration(
            color: widget.chat.isSent ? Colors.yellowAccent : Colors.redAccent,
            border: BoxBorder.all(
              color: colorScheme.onSecondary,
              style: BorderStyle.solid,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(widget.chat.text),
          ),
        ),
      ),
    );
  }
}
