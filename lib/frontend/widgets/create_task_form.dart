import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/logic/task/task_cubit.dart';
import '../../domain/entity/task_entity.dart';
import '../config/app_spacing.dart';
import 'color_select.dart';
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
    if (startDate.isBefore(now) && dueDate.isAfter(now)) {
      return TaskFilter.ongoing;
    } else {
      return TaskFilter.pending;
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const InputLabel(text: 'Todo title'),
        TaskTextField(hint: 'Enter a todo', controller: taskTitleController),
        AppSpacing.h16,

        const InputLabel(text: 'Description'),
        TaskTextField(
          hint: 'Enter todo description',
          maxLines: 3,
          controller: taskDescriptionController,
        ),
        AppSpacing.h16,

        const InputLabel(text: 'Start Date'),
        DateField(
          dateTime: widget.taskEntity?.startDate,
          date: (startDate) {
            selectedStartDate = startDate;
          },
        ),
        AppSpacing.h16,

        const InputLabel(text: 'Due Date'),
        DateField(
          dateTime: widget.taskEntity?.dueDate,
          date: (dueDate) {
            selectedDeuDate = dueDate;
          },
        ),
        AppSpacing.h16,

        Row(
          children: [
            const InputLabel(text: 'Priority'),
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
            const Text('Theme'),
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
          onTap: () {
            if (selectedStartDate.isAfter(selectedDeuDate)) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Invalid Due Date!'),
                  duration: const Duration(milliseconds: 500),
                  backgroundColor: colorScheme.primary,
                ),
              );
            } else {
              final TaskFilter filter = taskFilter(
                selectedStartDate,
                selectedDeuDate,
              );
              if (widget.updateOrCreate == 'Update') {
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
          },
        ),
      ],
    );
  }
}
