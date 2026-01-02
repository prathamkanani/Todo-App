import '../entity/task_entity.dart';

abstract interface class TaskRepository {
  Future<void> createTask(TaskEntity task);
  Future<void> updateTask(TaskEntity task);
}