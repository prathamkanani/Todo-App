import 'package:flutter/material.dart';
import '../../../../domain/entity/task_entity.dart';

class ColorSelect extends StatefulWidget {
  final TaskCardColor backgroundColor;
  final void Function(TaskCardColor) selectedColor;

  const ColorSelect({
    super.key,
    required this.backgroundColor,
    required this.selectedColor,
  });

  @override
  State<ColorSelect> createState() => _ColorSelectState();
}

class _ColorSelectState extends State<ColorSelect> {
  late TaskCardColor bgColor = widget.backgroundColor;

  void selectTaskCardColor(TaskCardColor color) {
    setState(() {
      bgColor = color;
    });
    widget.selectedColor(bgColor);
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    return Row(
      children: TaskCardColor.values.map<Widget>((final TaskCardColor color) {
        return GestureDetector(
          onTap: () => selectTaskCardColor(color),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: color.color.withValues(alpha: 0.7),
                shape: BoxShape.circle,
                border: BoxBorder.all(
                  style: BorderStyle.solid,
                  width: 2,
                  color: bgColor == color
                      ? colorScheme.onSecondary
                      : color.color,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
