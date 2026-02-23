import 'package:injectable/injectable.dart';
import 'package:scheck/features/auth/domain/entities/app_user.dart';
import 'package:scheck/features/auth/domain/repositories/auth_repository.dart';

@injectable
class SignIn {
  final AuthRepository _repository;

  SignIn(this._repository);

  Future<AppUser?> call({
    required String email,
    required String password,
  }) async {
    return await _repository.signIn(email: email, password: password);
  }
}
