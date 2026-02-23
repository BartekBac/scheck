import 'package:injectable/injectable.dart';
import 'package:scheck/features/auth/domain/entities/app_user.dart';
import 'package:scheck/features/auth/domain/repositories/auth_repository.dart';

@injectable
class SignUp {
  final AuthRepository _repository;

  SignUp(this._repository);

  Future<AppUser?> call({
    required String email,
    required String password,
    String? displayName,
  }) async {
    return await _repository.signUp(
      email: email,
      password: password,
      displayName: displayName,
    );
  }
}
