import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entity/task_entity.dart';
import '../../generated/l10n.dart';
import '../config/app_spacing.dart';

class TaskCardBottomRow extends StatelessWidget {
  const TaskCardBottomRow({
    super.key,
    required this.task,
  });

  final TaskEntity task;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);
    final ColorScheme colorScheme = ColorScheme.of(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: task.priority.color,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            Intl.message(task.priority.name),
            style: textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: colorScheme.secondary,
            ),
          ),
        ),
        AppSpacing.w08,
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.transparent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(Icons.calendar_month, size: 20),
              AppSpacing.w04,
              Text(
                DateFormat(
                  S.of(context).ddMmmYyyy,
                ).format(task.dueDate ?? DateTime.now()),
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.secondaryFixed,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}