import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:sqflite/sqflite.dart';
import '../../domain/entity/chat_entity.dart';
import '../../domain/entity/chat_group_entity.dart';
import '../model/chat_model.dart';
import 'task_database_init.dart';

abstract interface class ChatSource {
  Future<List<ChatEntity>> fetchChats();

  Future<List<ChatEntity>> fetchGroupedChats(ChatGroupEntity chatGroupEntity);

  Future<ChatEntity> send(ChatEntity chat);

  Stream<ChatEntity> sendPrompt(String prompt);

  Future<void> edit(ChatEntity chat);

  Future<void> delete(ChatEntity chat);

  Future<void> clear();
}

class LocalChatSource implements ChatSource {
  LocalTaskDatabase taskDatabase = LocalTaskDatabase();

  @override
  Future<List<ChatEntity>> fetchChats() async {
    final Database db = await taskDatabase.database;
    final List<Map<String, dynamic>> data = await db.query('chat');
    return data.map((e) => ChatModel.fromJson(e)).toList();
  }

  @override
  Future<List<ChatEntity>> fetchGroupedChats(
    ChatGroupEntity chatGroupEntity,
  ) async {
    final Database db = await taskDatabase.database;
    final List<Map<String, dynamic>> data = await db.query(
      'chat',
      where: 'chat_group_id = ?',
      whereArgs: [chatGroupEntity.id],
    );
    return data.map((e) => ChatModel.fromJson(e)).toList();
  }

  @override
  Future<ChatEntity> send(ChatEntity chat) async {
    final Database db = await taskDatabase.database;
    await db.insert(
      'chat',
      ChatModel.fromEntity(chat).toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return chat.sent(chat.chatGroupId!);
  }

  @override
  Future<void> edit(ChatEntity chat) async {
    final Database db = await taskDatabase.database;
    await db.update(
      'chat',
      ChatModel.fromEntity(chat).toJson(),
      where: 'id = ?',
      whereArgs: [chat.id],
    );
  }

  @override
  Future<void> delete(ChatEntity chat) async {
    final Database db = await taskDatabase.database;
    await db.delete('chat', where: 'id = ?', whereArgs: [chat.id]);
  }

  @override
  Future<void> clear() async {
    final Database db = await taskDatabase.database;
    await db.delete('chat');
  }

  @override
  Stream<ChatEntity> sendPrompt(String prompt) async* {
    Stream<Candidates?> candidates = Gemini.instance.promptStream(
      parts: [Part.text(prompt)],
    );
    await for (final candidate in candidates) {
      if (candidate?.output case String output) {
        yield ChatEntity.promptResponse(output);
      }
      if (candidate?.finishReason != null) return;
    }
  }
}
