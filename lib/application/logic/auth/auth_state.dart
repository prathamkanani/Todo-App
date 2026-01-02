import '../../../domain/entity/profile_entity.dart';

/// Base state for the [AuthCubit]
sealed class AuthState {}

/// Initial Loading state.
final class AuthLoading extends AuthState {}

/// State when a user is authenticated.
final class AuthAuthenticated extends AuthState {
  final ProfileEntity profile;

  AuthAuthenticated(this.profile);
}

/// State when a user is not authenticated.
final class AuthUnauthenticated extends AuthState {
  final String? message;

  AuthUnauthenticated({this.message});
}
