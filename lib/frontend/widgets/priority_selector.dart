import 'package:flutter/material.dart';
import '../../domain/entity/task_entity.dart';
import 'priority_container.dart';

class PrioritySelector extends StatefulWidget {
  final TaskPriority defaultPriority;
  final void Function(TaskPriority) selectedPriority;

  const PrioritySelector({
    super.key,
    required this.selectedPriority,
    required this.defaultPriority,
  });

  @override
  State<PrioritySelector> createState() => _PrioritySelectorState();
}

class _PrioritySelectorState extends State<PrioritySelector> {
  late TaskPriority priority = widget.defaultPriority;

  @override
  Widget build(BuildContext context) {
    return Row(
      // TODO: What is the difference between iterable and list.
      children: TaskPriority.values.map<Widget>((final TaskPriority element) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: PriorityContainer(
            currentPriority: element,
            onTap: () {
              setState(() {
                priority = element;
              });
              widget.selectedPriority(priority);
            },
            taskPriority: priority,
          ),
        );
      }).toList(),
    );
  }
}
