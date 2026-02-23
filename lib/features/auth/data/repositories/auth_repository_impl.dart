import 'package:injectable/injectable.dart';
import 'package:scheck/features/auth/data/datasources/supabase_auth_datasource.dart';
import 'package:scheck/features/auth/domain/entities/app_user.dart';
import 'package:scheck/features/auth/domain/repositories/auth_repository.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Stream<AppUser?> get authStateChanges => _dataSource.authStateChanges;

  @override
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) {
    return _dataSource.signIn(email: email, password: password);
  }

  @override
  Future<AppUser> signUp({
    required String email,
    required String password,
    String? displayName,
  }) {
    return _dataSource.signUp(
      email: email,
      password: password,
      displayName: displayName,
    );
  }

  @override
  Future<void> signOut() {
    return _dataSource.signOut();
  }

  @override
  Future<void> resetPassword(String email) {
    return _dataSource.resetPassword(email);
  }

  @override
  Future<AppUser> updateProfile({
    String? displayName,
    String? avatarUrl,
  }) {
    return _dataSource.updateProfile(
      displayName: displayName,
      avatarUrl: avatarUrl,
    );
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    return _dataSource.getCurrentUser();
  }
}
