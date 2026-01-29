import '../../../domain/entity/profile_entity.dart';

/// Base state for the [AuthCubit]
sealed class AuthState {}

/// Initial Loading state.
final class AuthLoading extends AuthState {}

/// State when a user is authenticated.
///
/// * [profile] : The authenticated profile [ProfileEntity].
final class AuthAuthenticated extends AuthState {
  final ProfileEntity profile;

  AuthAuthenticated(this.profile);
}

/// State when a user is not authenticated.
///
/// * [message] : The error message.
final class AuthUnauthenticated extends AuthState {
  final Object? message;

  AuthUnauthenticated({this.message});
}
