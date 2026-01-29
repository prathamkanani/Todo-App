import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../application/logic/task/task_cubit.dart';
import '../../../../domain/entity/task_entity.dart';
import '../../../../generated/l10n.dart';
import '../../../config/app_spacing.dart';
import 'task_color_select.dart';
import 'create_task_button.dart';
import 'date_field.dart';
import 'input_label.dart';
import 'priority_selector.dart';
import 'task_text_field.dart';

class CreateTaskForm extends StatefulWidget {
  final TaskEntity? taskEntity;
  final String updateOrCreate;

  const CreateTaskForm({
    super.key,
    this.taskEntity,
    required this.updateOrCreate,
  });

  @override
  State<CreateTaskForm> createState() => _CreateTaskFormState();
}

class _CreateTaskFormState extends State<CreateTaskForm> {
  final TaskPriority _selectedPriority = .medium;
  final TaskCardColor _taskCardColor = .blue;
  late TaskPriority selectedPriority =
      widget.taskEntity?.priority ?? _selectedPriority;
  late TaskCardColor taskCardColor =
      widget.taskEntity?.taskCardColor ?? _taskCardColor;
  late final TextEditingController taskTitleController,
      taskDescriptionController;
  late DateTime selectedStartDate =
      widget.taskEntity?.startDate ?? DateTime.now();
  late DateTime selectedDeuDate = widget.taskEntity?.dueDate ?? DateTime.now();

  @override
  void initState() {
    super.initState();
    taskTitleController = TextEditingController(text: widget.taskEntity?.title);
    taskDescriptionController = TextEditingController(
      text: widget.taskEntity?.description,
    );
  }

  @override
  void dispose() {
    taskDescriptionController.dispose();
    taskTitleController.dispose();
    super.dispose();
  }

  TaskFilter taskFilter(DateTime startDate, DateTime dueDate) {
    DateTime now = DateTime.now();
    if (startDate.isAtSameMomentAs(now) &&
        (dueDate.isAfter(now) || dueDate.isAtSameMomentAs(now))) {
      return TaskFilter.ongoing;
    } else {
      return TaskFilter.pending;
    }
  }

  void createTask(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    if (selectedStartDate.isAfter(selectedDeuDate)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(S.of(context).invalidDueDate),
          duration: const Duration(milliseconds: 500),
          backgroundColor: colorScheme.primary,
        ),
      );
    } else {
      final TaskFilter filter = taskFilter(selectedStartDate, selectedDeuDate);
      if (widget.updateOrCreate == S.of(context).update) {
        context.read<TaskCubit>().updateTask(
          TaskEntity(
            id: widget.taskEntity?.id,
            title: taskTitleController.text,
            description: taskDescriptionController.text,
            priority: selectedPriority,
            startDate: selectedStartDate,
            dueDate: selectedDeuDate,
            taskCardColor: taskCardColor,
            taskFilter: filter,
          ),
        );
      } else {
        context.read<TaskCubit>().createTask(
          TaskEntity(
            title: taskTitleController.text,
            description: taskDescriptionController.text,
            priority: selectedPriority,
            startDate: selectedStartDate,
            dueDate: selectedDeuDate,
            taskCardColor: taskCardColor,
            taskFilter: filter,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputLabel(text: S.of(context).todoTitle),
        TaskTextField(
          hint: S.of(context).enterATodo,
          controller: taskTitleController,
        ),
        AppSpacing.h16,

        InputLabel(text: S.of(context).description),
        TaskTextField(
          hint: S.of(context).enterTodoDescription,
          maxLines: 3,
          controller: taskDescriptionController,
        ),
        AppSpacing.h16,

        InputLabel(text: S.of(context).startDate),
        DateField(
          dateTime: widget.taskEntity?.startDate,
          date: (startDate) {
            selectedStartDate = startDate;
          },
        ),
        AppSpacing.h16,

        InputLabel(text: S.of(context).dueDate),
        DateField(
          dateTime: widget.taskEntity?.dueDate,
          date: (dueDate) {
            selectedDeuDate = dueDate;
          },
        ),
        AppSpacing.h16,

        Row(
          children: [
            InputLabel(text: S.of(context).priority),
            AppSpacing.w16,
            PrioritySelector(
              defaultPriority: widget.taskEntity?.priority ?? selectedPriority,
              selectedPriority: (priority) {
                selectedPriority = priority;
              },
            ),
          ],
        ),
        AppSpacing.h16,

        Row(
          children: [
            Text(S.of(context).theme),
            AppSpacing.w16,
            ColorSelect(
              backgroundColor:
                  widget.taskEntity?.taskCardColor ?? taskCardColor,
              selectedColor: (TaskCardColor color) {
                taskCardColor = color;
              },
            ),
          ],
        ),
        AppSpacing.h16,

        CreateTaskButton(
          updateOrCreate: widget.updateOrCreate,
          onTap: () => createTask(context),
        ),
      ],
    );
  }
}
