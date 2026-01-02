import 'package:flutter/material.dart';
import '../../infrastructure/extension/context_extension.dart';

class CustomBottomAppBar extends StatelessWidget {
  final Widget child;

  const CustomBottomAppBar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    return BottomAppBar(
      notchMargin: 5,
      elevation: 5,
      shadowColor: colorScheme.surfaceDim,
      padding: EdgeInsets.zero,
      shape: const CircularNotchedRectangle(),
      color: colorScheme.primaryContainer,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => context.push(child),
                icon: const Icon(Icons.home),
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ),
              const Text('Home'),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  context.push(child);
                },
                icon: const Icon(Icons.person),
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                ),
              ),
              const Text('Account'),
            ],
          ),
        ],
      ),
    );
  }
}
