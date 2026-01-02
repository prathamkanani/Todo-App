import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../application/logic/home_task/home_task_cubit.dart';
import '../../domain/entity/task_entity.dart';
import '../../generated/l10n.dart';
import '../../infrastructure/extension/context_extension.dart';
import '../config/app_spacing.dart';
import '../pages/create_task_page.dart';
import 'task_card_bottom_row.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task, required this.homeTaskCubit});

  final TaskEntity task;
  final HomeTaskCubit homeTaskCubit;

  void updateTask(BuildContext context) async {
    await context.push(CreateTaskPage(taskEntity: task));
    return homeTaskCubit.getFilteredTasks(homeTaskCubit.selectedFilter);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    final TextTheme textTheme = TextTheme.of(context);
    return GestureDetector(
      onTap: () => updateTask(context),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: task.taskCardColor?.color,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title ?? '',
                    style: textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    task.description ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium?.copyWith(
                      color: colorScheme.onTertiary,
                    ),
                  ),
                  AppSpacing.h24,
                  TaskCardBottomRow(task: task),
                ],
              ),
            ),
            AppSpacing.w04,
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.transparent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                Intl.message(task.taskFilter?.name ?? S.of(context).pending),
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: colorScheme.secondaryFixed,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
