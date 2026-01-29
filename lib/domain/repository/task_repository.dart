import '../entity/task_entity.dart';

/// Defines the contracts for the task itself.
abstract interface class TaskRepository {
  /// This allows user to create a new task.
  Future<void> createTask(TaskEntity task);

  /// This allows user to update an existing task.
  Future<void> updateTask(TaskEntity task);
}