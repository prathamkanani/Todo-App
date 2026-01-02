import 'dart:ui';

enum TaskFilter {
  all(0),
  ongoing(1),
  pending(2),
  completed(3);

  final int idx;

  const TaskFilter(this.idx);
}

enum TaskPriority {
  low(Color(0xffffb769)),
  medium(Color(0xfffe8b96)),
  high(Color(0xff5fd5ff));

  final Color color;

  const TaskPriority(this.color);
}

enum TaskCardColor {
  red(Color(0xffffcad1)),
  yellow(Color(0xffffe3c3)),
  blue(Color(0xffcff2ff));

  final Color color;

  const TaskCardColor(this.color);
}

class TaskEntity {
  final int? id;
  final TaskFilter? taskFilter;
  final TaskCardColor? taskCardColor;
  final String? title;
  final String? description;
  final TaskPriority priority;
  final DateTime? startDate;
  final DateTime? dueDate;

  TaskEntity({
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
