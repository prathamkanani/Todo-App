import 'package:sqflite/sqflite.dart';
import '../../domain/entity/chat_entity.dart';
import '../model/chat_model.dart';
import 'task_database_init.dart';

abstract interface class ChatSource {
  Future<List<ChatEntity>> fetchChats();

  Future<ChatEntity> send(ChatEntity chat);
}

class LocalChatSource implements ChatSource {
  LocalTaskDatabase taskDatabase = LocalTaskDatabase();

  @override
  Future<List<ChatEntity>> fetchChats() async {
    final Database db = await taskDatabase.database;
    final data = await db.query('chat');
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
    return chat.sent();
  }
}
