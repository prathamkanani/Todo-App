import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../domain/entity/task_entity.dart';

class PriorityContainer extends StatelessWidget {
  final TaskPriority currentPriority;
  final TaskPriority taskPriority;
  final VoidCallback onTap;

  const PriorityContainer({
    required this.taskPriority,
    required this.currentPriority,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: currentPriority == taskPriority
              ? taskPriority.color
              : colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          Intl.message(currentPriority.name),
          style: TextStyle(
            color: currentPriority == taskPriority
                ? colorScheme.secondary
                : colorScheme.onSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
