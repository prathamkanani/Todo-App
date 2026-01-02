import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/formatters/phone_number_formatter.dart';
import '../../application/logic/profile/profile_cubit.dart';
import '../../application/logic/profile/profile_state.dart';
import '../../application/validators/email_validator.dart';
import '../../application/validators/name_validator.dart';
import '../../domain/entity/profile_entity.dart';
import '../config/app_spacing.dart';
import 'user_avatar.dart';

/// User Profile UI
class ProfileView extends StatefulWidget {
  const ProfileView({
    super.key,
    required this.profileEntity,
    required this.profileCubit,
  });

  final ProfileEntity profileEntity;
  final ProfileCubit profileCubit;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final TextEditingController fullNameController,
      emailController,
      mobileNumController;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    mobileNumController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    mobileNumController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            // User Avatar
            UserAvatar(
              profileCubit: widget.profileCubit,
              profileEntity: widget.profileEntity,
            ),
            AppSpacing.h16,

            // Full Name Text Field
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text(
                'Full Name',
                style: TextStyle(color: colorScheme.onSecondaryContainer),
              ),
            ),
            AppSpacing.h04,
            TextFormField(
              controller: fullNameController,
              validator: (value) => nameValidator(value),
              style: TextStyle(color: colorScheme.onSecondary),
              decoration: InputDecoration(
                hintText: 'Enter your full name',
                hintStyle: TextStyle(color: colorScheme.onSecondaryContainer),
                contentPadding: EdgeInsets.zero,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            AppSpacing.h16,

            // Email Text Field
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text(
                'Email',
                style: TextStyle(color: colorScheme.onSecondaryContainer),
              ),
            ),
            AppSpacing.h04,
            TextFormField(
              controller: emailController,
              validator: (value) => emailValidator(value),
              style: TextStyle(color: colorScheme.onSecondary),
              decoration: InputDecoration(
                hintText: 'Enter your email',
                hintStyle: TextStyle(color: colorScheme.onSecondaryContainer),
                contentPadding: EdgeInsets.zero,
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            AppSpacing.h16,

            // Mobile Number Text Field
            Align(
              alignment: AlignmentGeometry.centerLeft,
              child: Text(
                'Mobile Number',
                style: TextStyle(color: colorScheme.onSecondaryContainer),
              ),
            ),
            AppSpacing.h04,
            TextFormField(
              controller: mobileNumController,
              keyboardType: TextInputType.number,
              style: TextStyle(color: colorScheme.onSecondary),
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                PhoneInputFormatter(maxLength: 10)
              ],
              decoration: InputDecoration(
                hintText: 'Enter your mobile number',
                hintStyle: TextStyle(color: colorScheme.onSecondaryContainer),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            AppSpacing.h24,

            // Button to save the profile
            ElevatedButton(
              onPressed: () => widget.profileCubit.saveProfile(
                profile: widget.profileEntity,
                seed: widget.profileEntity.avatarUrl ?? '',
              ),
              child: BlocBuilder<ProfileCubit, ProfileState>(
                bloc: widget.profileCubit,
                builder: (BuildContext context, ProfileState state) {
                  if(state is ProfileLoadingState) {
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  return const Text(
                    'Save Profile',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
