import 'package:scheck/features/auth/domain/entities/app_user.dart';

abstract class AuthRepository {
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

  Future<AppUser?> getCurrentUser();
}
