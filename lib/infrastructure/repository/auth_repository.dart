import '../../domain/entity/profile_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../source/auth_source.dart';

/// Concrete implementation of the authentication repository.
class AuthRepositoryImpl implements AuthRepository {
  final SupabaseAuthSource source;

  AuthRepositoryImpl(this.source);

  @override
  ProfileEntity? getUser() {
    return source.getUser();
  }

  @override
  Future<ProfileEntity?> signIn() async {
    final user = await source.signIn();
    return user;
  }

  @override
  Future<void> signOut() async {
    await source.signOut();
  }
}
