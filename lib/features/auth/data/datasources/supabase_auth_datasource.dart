import 'package:injectable/injectable.dart';
import 'package:scheck/features/auth/domain/entities/app_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthDataSource {
  Stream<AppUser?> get authStateChanges;
  Future<AppUser> signIn({
    required String email,
    required String password,
  });
  Future<AppUser> signUp({
    required String email,
    required String password,
    String? displayName,
  });
  Future<void> signOut();
  Future<void> resetPassword(String email);
  Future<AppUser> updateProfile({
    String? displayName,
    String? avatarUrl,
  });
  AppUser? getCurrentUser();
}

@LazySingleton(as: AuthDataSource)
class SupabaseAuthDataSource implements AuthDataSource {
  final SupabaseClient _supabaseClient;

  SupabaseAuthDataSource(this._supabaseClient);

  AppUser _mapSupabaseUser(User user) {
    return AppUser(
      id: user.id,
      email: user.email ?? '',
      displayName: user.userMetadata?['display_name'].toString(),
      avatarUrl: user.userMetadata?['avatar_url'].toString(),
      createdAt: DateTime.parse(user.createdAt),
      updatedAt:
          user.updatedAt != null ? DateTime.parse(user.updatedAt!) : null,
    );
  }


  @override
  Stream<AppUser?> get authStateChanges {
    return _supabaseClient.auth.onAuthStateChange.map((authState) {
      switch(authState.event) {

        case AuthChangeEvent.initialSession:
        case AuthChangeEvent.passwordRecovery:
        case AuthChangeEvent.tokenRefreshed:
        case AuthChangeEvent.mfaChallengeVerified:
        case AuthChangeEvent.signedIn:
        case AuthChangeEvent.userUpdated:
          if(authState.session != null) {
            return _mapSupabaseUser(authState.session!.user);
          }
          print('ERROR: capturing auth state [${authState.toString()}] session is not active.');
        case AuthChangeEvent.userDeleted:
        case AuthChangeEvent.signedOut:
          return null;
      }
    });
  }

  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _supabaseClient.auth
        .signInWithPassword(email: email, password: password);

    if (response.user == null) {
      throw const AuthException('Sign in failed: User is null.');
    }
    return _mapSupabaseUser(response.user!);
  }

  @override
  Future<AppUser> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    final response = await _supabaseClient.auth.signUp(
      email: email,
      password: password,
      data: displayName != null ? {'display_name': displayName} : null,
    );
    if (response.user == null) {
      throw const AuthException('Sign up failed: User is null.');
    }
    return _mapSupabaseUser(response.user!);
  }

  @override
  Future<void> signOut() async {
    await _supabaseClient.auth.signOut();
  }

  @override
  Future<void> resetPassword(String email) async {
    await _supabaseClient.auth.resetPasswordForEmail(email);
  }

  @override
  Future<AppUser> updateProfile({
    String? displayName,
    String? avatarUrl,
  }) async {
    final metadata = <String, dynamic>{};
    if (displayName != null) metadata['display_name'] = displayName;
    if (avatarUrl != null) metadata['avatar_url'] = avatarUrl;
    
    final response = await _supabaseClient.auth.updateUser(
      UserAttributes(data: metadata),
    );

    if (response.user == null) {
      throw const AuthException('Update profile failed: User is null.');
    }
    return _mapSupabaseUser(response.user!);
  }

  @override
  AppUser? getCurrentUser() {
    final supabaseUser = _supabaseClient.auth.currentUser;
    if (supabaseUser == null) {
      return null;
    }
    return _mapSupabaseUser(supabaseUser);
  }
}
