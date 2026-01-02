import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/logic/chat/chat_cubit.dart';
import '../../application/logic/chat/chat_state.dart';
import '../../domain/entity/chat_entity.dart';
import '../../infrastructure/app_injector.dart';
import '../config/app_spacing.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPage();
}

class _ChatPage extends State<ChatPage> {
  late final ChatCubit chatCubit;
  late final TextEditingController controller;
  late List<ChatEntity> chat = chatCubit.chats;

  @override
  void initState() {
    super.initState();
    chatCubit = locator.get<ChatCubit>()..fetchChats();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    chatCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<ChatCubit, ChatState>(
                    bloc: chatCubit,
                    builder: (context, state) {
                      return switch (state) {
                        ChatLoadingState() => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        ChatLoadedState() => ListView.separated(
                          reverse: true,
                          separatorBuilder: (_, _) => AppSpacing.h08,
                          itemBuilder: (context, final int index) {
                            final int idx = chat.length - index - 1;
                            return Align(
                              alignment: AlignmentGeometry.centerRight,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: chat[idx].isSent
                                      ? Colors.yellowAccent
                                      : Colors.redAccent,
                                  border: BoxBorder.all(
                                    color: colorScheme.onSecondary,
                                    style: BorderStyle.solid,
                                  ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 4.0,
                                  ),
                                  child: Text(chat[idx].text),
                                ),
                              ),
                            );
                          },
                          itemCount: chat.length,
                        ),
                        ChatLoadingErrorState() => const Center(
                          child: Text('Loading chat failed!'),
                        ),
                      };
                    },
                  ),
                ),
                AppSpacing.h16,
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'Ask anything',
                    suffixIcon: IconButton(
                      onPressed: () {
                        chatCubit.sendChat(
                          ChatEntity(
                            text: controller.text,
                            sentTime: DateTime.now(),
                            isSelf: false,
                            isSent: true,
                          ),
                        );
                        controller.clear();
                      },
                      icon: const Icon(Icons.send),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
