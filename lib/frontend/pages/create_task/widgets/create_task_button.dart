import 'package:flutter/material.dart';

class CreateTaskButton extends StatelessWidget {
  final VoidCallback onTap;
  final String updateOrCreate;

  const CreateTaskButton({
    super.key,
    required this.onTap,
    required this.updateOrCreate,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    return SizedBox(
      child: ElevatedButton(
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: colorScheme.secondary),
            Text(
              '$updateOrCreate Task',
              style: TextStyle(color: colorScheme.secondary),
            ),
          ],
        ),
      ),
    );
  }
}
