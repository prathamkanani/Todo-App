import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

/// App name and tag line
class AppInfo extends StatelessWidget {
  const AppInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = TextTheme.of(context);
    final ColorScheme colorScheme = ColorScheme.of(context);
    return Column(
      children: [
        Text(
          S.of(context).todoApp,
          style: textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: colorScheme.onSecondary,
          ),
        ),
        Text(
          S.of(context).theSmarterWayToManageWork,
          style: textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w400,
            color: colorScheme.onSecondary,
          ),
        ),
      ],
    );
  }
}
