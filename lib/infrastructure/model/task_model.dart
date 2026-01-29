import '../../domain/entity/task_entity.dart';

/// Task Model for data transfer.
class TaskModel extends TaskEntity {
  TaskModel({
    super.taskFilter,
    super.taskCardColor,
    required super.id,
    required super.title,
    required super.description,
    required super.priority,
    required super.startDate,
    required super.dueDate,
  });

  /// This converts from [TaskEntity] to [TaskModel].
  factory TaskModel.fromEntity(TaskEntity task) {
    return TaskModel(
      id: task.id,
      title: task.title ?? '',
      description: task.description ?? '',
      priority: task.priority,
      taskFilter: task.taskFilter,
      taskCardColor: task.taskCardColor,
      startDate: task.startDate ?? DateTime.now(),
      dueDate: task.dueDate ?? DateTime.now(),
    );
  }

  /// This converts the data received from database to [TaskModel]
  /// For showing the received data in the UI.
  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String?,
      taskFilter: TaskFilter.values[json['filter']],
      taskCardColor: TaskCardColor.values[json['color']],
      priority: TaskPriority.values[json['priority']],
      startDate: DateTime.parse(json['start_date']) as DateTime?,
      dueDate: DateTime.parse(json['due_date']) as DateTime?,
    );
  }

  /// This method is used to store the [TaskEntity] into the database.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority.index,
      'filter': taskFilter?.index ?? 2,
      'color': taskCardColor?.index ?? 4,
      'start_date': startDate.toString(),
      'due_date': dueDate.toString(),
    };
  }
}
