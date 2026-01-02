import '../../domain/entity/profile_entity.dart';

/// Data-Transfer Object for the profile entity.
class ProfileModel extends ProfileEntity {
  /// Creates an immutable [ProfileEntity]
  ProfileModel({
    required super.userId,
    super.profileId,
    super.avatarUrl,
    super.fullName,
    super.email,
    super.mobileNumber,
  });

  /// Creates Profile DTO from Json(from database)
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      userId: json['uid'] as String,
      avatarUrl: json['avatar_url'] as String?,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      mobileNumber: json['mobile_number'] as String?,
    );
  }
}
