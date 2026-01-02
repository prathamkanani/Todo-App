import 'package:flutter/material.dart';
import '../../application/logic/auth/auth_cubit.dart';
import '../config/app_assets.dart';
import '../config/app_spacing.dart';
import 'app_info.dart';
import 'consent_text.dart';
import 'google_signin.dart';

/// UI for the Login Page
class LoginView extends StatelessWidget {
  final AuthCubit authCubit;

  const LoginView({super.key, required this.authCubit});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = ColorScheme.of(context);
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Spacer(),
                Image.asset(AppAssets.appLogo, height: 100, width: 100),
                AppSpacing.h08,
                const AppInfo(),
                AppSpacing.h24,
                SignInWithGoogleButton(onPressed: () => authCubit.signIn()),
                AppSpacing.h08,
                const Spacer(),
                ConsentText(colorScheme: colorScheme),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
