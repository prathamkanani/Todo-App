import '../entity/task_entity.dart';

/// Defines the contracts for the home page tasks.
abstract interface class HomeTaskRepository {
  /// This gets all the filtered tasks list.
  Future<List<TaskEntity>> getFilteredTasks(TaskFilter filter);

  /// This marks a task status to completed.
  Future<void> markAsComplete(TaskEntity task);

  /// This reverts the task status back to original.
  Future<void> revert(TaskEntity task);

  /// This deletes the task entirely.
  Future<void> deleteTask(int id);
}