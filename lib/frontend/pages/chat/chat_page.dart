import 'package:flutter/material.dart';
import '../../../application/logic/chat/chat_cubit.dart';
import '../../../application/logic/chat_group/chat_group_cubit.dart';
import '../../../domain/entity/chat_entity.dart';
import '../../../domain/entity/chat_group_entity.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructure/app_injector.dart';
import '../../config/app_spacing.dart';
import 'widgets/ask_anything_field.dart';
import 'widgets/chat_view.dart';
import 'widgets/drawer_content.dart';

/// # Chat Page UI
///
/// ## Features:
///
///
class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPage();
}

/// Chat Page [State] Object.
class _ChatPage extends State<ChatPage> {
  /// Late [ChatCubit] initialization
  late final ChatCubit chatCubit;

  /// Late [ChatGroupCubit] initialization
  late final ChatGroupCubit chatGroupCubit;

  /// Late [TextEditingController] initialization
  late final TextEditingController controller;

  /// Accessing chats from [ChatCubit]
  late List<ChatEntity> chats = chatCubit.chats;

  /// Giving a [FocusNode] to [TextFormField] for control.
  late final FocusNode chatFocusNode;

  @override
  void initState() {
    super.initState();

    // Initializing the ChatGroupCubit using Locator.
    chatGroupCubit = locator.get<ChatGroupCubit>()..loadAllChats();

    // Initializing the ChatCubit using Locator.
    chatCubit = locator.get<ChatCubit>()..homeScreen();

    // Initializing the text controller.
    controller = TextEditingController();

    // Initializing text field with FocusNode.
    chatFocusNode = FocusNode();
  }

  @override
  void dispose() {

    // Disposing controller
    controller.dispose();

    // Closing ChatGroupCubit
    chatGroupCubit.close();


    chatCubit.close();
    chatFocusNode.dispose();
    super.dispose();
  }

  void sendChat() {
    if (chatGroupCubit.createdGroup == false) {
      chatGroupCubit.createNewChatGroup(
        ChatGroupEntity(
          chatGroupTitle: controller.text,
          createdAt: DateTime.now(),
        ),
        (id) {
          chatGroupCubit.randomId = id;
        },
      );
    } else {
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
    chatGroupCubit.createdGroup = true;
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    return GestureDetector(
      onTap: () {
        chatFocusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: colorScheme.secondary,
        drawer: Drawer(
          backgroundColor: colorScheme.secondary,
          child: DrawerContent(
            chatCubit: chatCubit,
            chatGroupCubit: chatGroupCubit,
          ),
        ),
        appBar: AppBar(title: Text(S.of(context).ai)),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                AppSpacing.h08,
                ChatView(
                  chatCubit: chatCubit,
                  chatGroupCubit: chatGroupCubit,
                  controller: controller,
                  chats: chats,
                ),
                AppSpacing.h16,
                AskAnythingField(
                  controller: controller,
                  chatFocusNode: chatFocusNode,
                  chatCubit: chatCubit,
                  chatGroupCubit: chatGroupCubit,
                  sendChat: sendChat,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
