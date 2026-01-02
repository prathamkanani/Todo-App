import 'package:flutter/material.dart';
import '../../application/logic/profile/profile_cubit.dart';
import '../../domain/entity/profile_entity.dart';
import '../../generated/l10n.dart';
import '../../infrastructure/app_injector.dart';
import '../../infrastructure/extension/context_extension.dart';
import '../shared/base_page.dart';
import '../widgets/profile_view.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  final ProfileEntity profileEntity;

  const ProfilePage({super.key, required this.profileEntity});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late final ProfileCubit profileCubit;

  @override
  void initState() {
    super.initState();
    profileCubit = locator.get<ProfileCubit>()
      ..createProfile(profile: widget.profileEntity);
  }

  @override
  void dispose() {
    profileCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    final textScheme = TextTheme.of(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: BasePage(
        appBar: AppBar(
          title: Text(
            S.of(context).userProfile,
            style: textScheme.headlineSmall?.copyWith(
              color: colorScheme.onSecondary,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.pushAndRemoveUntil(const LoginPage());
              },
              icon: const Icon(Icons.logout_rounded),
              color: colorScheme.onSecondary,
            ),
          ],
          backgroundColor: colorScheme.secondary,
        ),
        child: ProfileView(
          profileCubit: profileCubit,
          profileEntity: widget.profileEntity,
        ),
      ),
    );
  }
}
