import 'package:flutter/material.dart';

class TaskTextField extends StatelessWidget {
  final String hint;
  final int maxLines;
  final TextEditingController controller;

  const TaskTextField({
    required this.hint,
    required this.controller,
    this.maxLines = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: colorScheme.onPrimary,
      ),
    );
  }
}
