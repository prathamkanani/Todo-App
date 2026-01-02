import '../../../domain/entity/task_entity.dart';

sealed class TaskState {}

final class TaskLoadingState extends TaskState {}

final class TaskUpdateState extends TaskState {}

final class TaskUpdatedState extends TaskState {
  final TaskEntity task;
  TaskUpdatedState({required this.task});
}

final class TaskErrorState extends TaskState {
  final Object? error;
  TaskErrorState({required this.error});
}