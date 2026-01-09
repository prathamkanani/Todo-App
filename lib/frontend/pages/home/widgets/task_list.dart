import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../../application/logic/home_task/home_task_cubit.dart';
import '../../../../domain/entity/task_entity.dart';
import '../../../../generated/l10n.dart';
import '../../../config/app_spacing.dart';
import 'task_card.dart';

class TaskList extends StatelessWidget {
  final HomeTaskCubit homeTaskCubit;
  final List<TaskEntity> tasks;

  const TaskList({super.key, required this.homeTaskCubit, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    return SliverList.separated(
      itemCount: tasks.length,
      separatorBuilder: (_, _) => AppSpacing.h16,
      itemBuilder: (context, final int index) {
        final TaskEntity task = tasks[index];
        bool isComplete = false;
        if (task.taskFilter?.name == S.of(context).completed) {
          isComplete = true;
        } else {
          isComplete = false;
        }
        return Slidable(
          key: ValueKey(index),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                onPressed: (BuildContext context) {
                  if (task.id != null) {
                    homeTaskCubit.deleteTask(task.id!);
                  }
                },
                backgroundColor: colorScheme.tertiaryContainer.withValues(
                  alpha: 0.5,
                ),
                foregroundColor: colorScheme.secondary,
                icon: Icons.delete,
                label: S.of(context).delete,
              ),
              SlidableAction(
                onPressed: (BuildContext context) {
                  if (!isComplete) {
                    homeTaskCubit.markAsComplete(task);
                  } else {
                    homeTaskCubit.revert(task);
                  }
                },
                backgroundColor: colorScheme.primary.withValues(alpha: 0.5),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                foregroundColor: colorScheme.secondary,
                icon: Icons.check_box,
                label: isComplete
                    ? S.of(context).revert
                    : S.of(context).complete,
              ),
              const SizedBox(width: 16),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: TaskCard(task: task, homeTaskCubit: homeTaskCubit),
          ),
        );
      },
    );
  }
}
