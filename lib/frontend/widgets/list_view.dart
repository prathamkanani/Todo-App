import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../application/logic/home_task/home_task_cubit.dart';
import '../../domain/entity/task_entity.dart';
import '../config/app_spacing.dart';

class HorizontalListView extends StatefulWidget {
  final HomeTaskCubit cubit;
  const HorizontalListView({super.key, required this.cubit});

  @override
  State<HorizontalListView> createState() => _HorizontalListViewState();
}

class _HorizontalListViewState extends State<HorizontalListView> {

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      height: 75,
      decoration: BoxDecoration(
        color: colorScheme.secondary,
        boxShadow: <BoxShadow>[
          BoxShadow(color: colorScheme.secondaryContainer, blurRadius: 20),
        ]
      ),
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 8.0),
        scrollDirection: Axis.horizontal,
        itemCount: TaskFilter.values.length,
        separatorBuilder: (_, _) => AppSpacing.w08,
        itemBuilder: (context, final int index) {
          final TaskFilter filter = TaskFilter.values[index];
          final bool isSelected = filter == widget.cubit.selectedFilter;
          return GestureDetector(
            onTap: () {
              setState(() {
                widget.cubit.selectedFilter = filter;
              });
              widget.cubit.getFilteredTasks(widget.cubit.selectedFilter);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? colorScheme.onSecondaryContainer
                    : colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Center(child: Text(Intl.message(filter.name))),
            ),
          );
        },
      ),
    );
  }
}
