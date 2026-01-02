/// Represents basic user information
class ProfileEntity {
  /// Unique user ID.
  final String userId;

  /// Unique profile ID.
  final String? profileId;

  /// User avatar URL.
  final String? avatarUrl;

  /// Full name of the user.
  final String? fullName;

  /// Email of the user.
  final String? email;

  /// Mobile Number of the user.
  final String? mobileNumber;

  /// Created an immutable instance of [ProfileEntity].
  ProfileEntity({
    required this.userId,
    this.profileId,
    this.avatarUrl,
    this.fullName,
    this.email,
    this.mobileNumber,
  });
}
