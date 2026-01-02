import '../entity/task_entity.dart';

abstract interface class HomeTaskRepository {
  Future<List<TaskEntity>> getFilteredTasks(TaskFilter filter);
  Future<void> markAsComplete(TaskEntity task);
  Future<void> revert(TaskEntity task);
  Future<void> deleteTask(int id);
}