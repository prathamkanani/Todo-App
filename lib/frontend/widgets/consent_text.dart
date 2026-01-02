import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

/// Consent Text for playstore/appstore approval
class ConsentText extends StatelessWidget {
  const ConsentText({super.key, required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          S.of(context).byContinuingYouAgreeToOur,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSecondary,
          ),
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: colorScheme.primary,
            ),
            children: <TextSpan>[
              TextSpan(
                text: S.of(context).privacyPolicies,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.tertiary,
                ),
              ),
              TextSpan(
                text: S.of(context).and,
                style: TextStyle(color: colorScheme.onSecondary),
              ),
              TextSpan(
                text: S.of(context).termsConditions,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: colorScheme.tertiary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
