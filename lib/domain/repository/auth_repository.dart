import '../entity/profile_entity.dart';

/// Defines contracts for authentication.
abstract interface class AuthRepository {
  /// Lets the user sign in.
  Future<ProfileEntity?> signIn();

  /// Gets user details from the current session.
  ProfileEntity? getUser();

  /// Signs out the user.
  Future<void> signOut();
}