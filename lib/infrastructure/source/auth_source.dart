import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../domain/entity/profile_entity.dart';
import '../../env.dart';

/// Defines contracts for authentication operations.
abstract interface class AuthDataSource {
  Future<ProfileEntity?> signIn();
  Future<void> signOut();
  ProfileEntity? getUser();
}

class SupabaseAuthSource implements AuthDataSource {
  final SupabaseClient supabase;

  SupabaseAuthSource(this.supabase);

  final GoogleSignIn googleSignIn = GoogleSignIn.instance;

  /// Gets user from supabase current session.
  @override
  ProfileEntity? getUser() {
    final Session? session = supabase.auth.currentSession;
    if (session == null) return null;
    return ProfileEntity(userId: session.user.id);
  }

  /// Lets user sign in through Google sign in.
  @override
  Future<ProfileEntity?> signIn() async {
    // Initializing the Google sign in.
    await googleSignIn.initialize(
      serverClientId: webClientId,
      clientId: iOSClientId,
    );

    // Perform the sign in.
    // This opens native google account picker.
    final GoogleSignInAccount googleAccount = await googleSignIn.authenticate();

    // This requests explicit permission from
    // user to access their email and profile.
    final GoogleSignInClientAuthorization? googleAuthorization =
        await googleAccount.authorizationClient.authorizationForScopes([
          'email',
        ]);

    // Extracting the tokens.
    final GoogleSignInAuthentication googleAuthentication =
        googleAccount.authentication;
    final String? idToken = googleAuthentication.idToken;
    final String? accessToken = googleAuthorization?.accessToken;

    if (idToken == null) {
      throw 'No ID Token found.';
    }

    // Handing over to supabase.
    final AuthResponse result = await supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );

    // Get the current user.
    final User currentUser = result.user!;

    // Converts supabase's user to profile entity.
    return ProfileEntity(userId: currentUser.id);
  }

  /// Lets the user sign out from supabase and google.
  @override
  Future<void> signOut() async {
    await supabase.auth.signOut();
    await googleSignIn.signOut();
  }
}
