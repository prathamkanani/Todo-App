import 'dart:ui';

/// For filtering of Task based on all, ongoing, pending, completed.
enum TaskFilter {
  all(0),
  ongoing(1),
  pending(2),
  completed(3);

  /// The index for storing current filter in the database.
  final int idx;

  /// Creating instance of [TaskFilter].
  const TaskFilter(this.idx);
}

/// For color selection based on selected Task priority low, medium, high.
enum TaskPriority {
  low(Color(0xffffb769)),
  medium(Color(0xfffe8b96)),
  high(Color(0xff5fd5ff));

  /// The color based selection of [TaskPriority].
  final Color color;

  /// Creating instance of selected [TaskPriority].
  const TaskPriority(this.color);
}

/// For selecting the color of the task card [TaskCardColor].
enum TaskCardColor {
  red(Color(0xffffcad1)),
  yellow(Color(0xffffe3c3)),
  blue(Color(0xffcff2ff));

  /// The color selected for the task card.
  final Color color;

  /// Creating instance of selected [TaskCardColor].
  const TaskCardColor(this.color);
}

/// Defines the task in the application [TaskEntity].
class TaskEntity {
  /// Unique id for each task to store in the database.
  final int? id;

  /// Selected filter this task belongs to.
  final TaskFilter? taskFilter;

  /// Selected task card color.
  final TaskCardColor? taskCardColor;

  /// The title for the task.
  final String? title;

  /// The description of the task.
  final String? description;

  /// Selected priority of the task.
  final TaskPriority priority;

  /// Selected start date of the task.
  final DateTime? startDate;

  /// Selected due date of the task.
  final DateTime? dueDate;

  /// Creating instance of the [TaskEntity].
  const TaskEntity({
    this.id,
    this.taskFilter,
    this.taskCardColor,
    required this.title,
    required this.description,
    required this.priority,
    required this.startDate,
    required this.dueDate,
  });
}
