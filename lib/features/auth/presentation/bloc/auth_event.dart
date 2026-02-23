part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.started() = _Started;
  const factory AuthEvent.signInRequested({
    required String email,
    required String password,
  }) = _SignInRequested;
  const factory AuthEvent.signUpRequested({
    required String email,
    required String password,
    String? displayName,
  }) = _SignUpRequested;
  const factory AuthEvent.signOutRequested() = _SignOutRequested;
  const factory AuthEvent.resetPasswordRequested(String email) = _ResetPasswordRequested;
  const factory AuthEvent.updateProfileRequested({
    String? displayName,
    String? avatarUrl,
  }) = _UpdateProfileRequested;
  const factory AuthEvent.authStateChanged(AppUser? user) = _AuthStateChanged;
}
