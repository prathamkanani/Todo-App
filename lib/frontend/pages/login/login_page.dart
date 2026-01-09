import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../application/logic/auth/auth_cubit.dart';
import '../../../application/logic/auth/auth_state.dart';
import '../../../domain/entity/profile_entity.dart';
import '../../../generated/l10n.dart';
import '../../../infrastructure/app_injector.dart';
import 'widgets/login_view.dart';
import '../home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final AuthCubit authCubit;

  @override
  void initState() {
    super.initState();
    authCubit = locator.get<AuthCubit>()..getUser();
  }

  @override
  void dispose() {
    authCubit.close();
    super.dispose();
  }

  /// Navigating to the User Profile page
  void _listenToAuthState(BuildContext context, final AuthState state) {
    if (state is AuthAuthenticated) {
      final ProfileEntity profile = state.profile;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(profileEntity: profile),
        ),
        (context) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        bloc: authCubit,
        listener: _listenToAuthState,
        builder: (context, state) {
          return switch (state) {
            AuthLoading() => const Center(child: CircularProgressIndicator()),
            AuthAuthenticated() => Center(
              child: Text(S.of(context).authenticated),
            ),
            AuthUnauthenticated() => LoginView(authCubit: authCubit),
          };
        },
      ),
    );
  }
}
