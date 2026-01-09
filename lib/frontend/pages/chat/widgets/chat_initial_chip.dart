import 'package:flutter/material.dart';
import '../../../../application/logic/chat/chat_cubit.dart';
import '../../../../application/logic/chat_group/chat_group_cubit.dart';

class ChatInitialChip extends StatelessWidget {
  final VoidCallback onTap;
  final ChatCubit chatCubit;
  final ChatGroupCubit chatGroupCubit;
  final String chipTitle;

  const ChatInitialChip({
    super.key,
    required this.onTap,
    required this.chipTitle,
    required this.chatCubit,
    required this.chatGroupCubit,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Align(
        alignment: AlignmentGeometry.centerLeft,
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(chipTitle),
          ),
        ),
      ),
    );
  }
}
