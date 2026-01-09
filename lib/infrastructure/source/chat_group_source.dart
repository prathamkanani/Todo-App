import 'package:sqflite/sqflite.dart';
import '../../domain/entity/chat_group_entity.dart';
import '../model/chat_group_model.dart';
import 'task_database_init.dart';

abstract interface class ChatGroupSource {
  Future<List<ChatGroupEntity>> loadAllChats();
  Future<ChatGroupEntity> createNewChatGroup(ChatGroupEntity chatGroupEntity);
  Future<ChatGroupEntity> loadChat(ChatGroupEntity chatGroupEntity);
}

class LocalChatGroupSource implements ChatGroupSource {
  LocalTaskDatabase taskDatabase = LocalTaskDatabase();

  @override
  Future<List<ChatGroupEntity>> loadAllChats() async {
    final Database db = await taskDatabase.database;
    final chats = await db.query('chat_group');
    return chats.map((e) => ChatGroupModel.fromJson(e)).toList();
  }

  @override
  Future<ChatGroupEntity> createNewChatGroup(ChatGroupEntity chatGroupEntity) async {
    final Database db = await taskDatabase.database;
    final id = await db.insert(
      'chat_group',
      ChatGroupModel.fromEntity(chatGroupEntity).toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return chatGroupEntity.withId(id);
  }

  @override
  Future<ChatGroupEntity> loadChat(
    ChatGroupEntity chatGroupEntity,
  ) async {
    final Database db = await taskDatabase.database;
    final chats = await db.query(
      'chat_group',
      where: 'id = ?',
      whereArgs: [chatGroupEntity.id],
    );
    return chats.map((e) => ChatGroupModel.fromJson(e)).first;
  }
}
