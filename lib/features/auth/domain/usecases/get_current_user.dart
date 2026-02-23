import 'package:injectable/injectable.dart';
import 'package:scheck/features/auth/domain/entities/app_user.dart';
import 'package:scheck/features/auth/domain/repositories/auth_repository.dart';

@injectable
class GetCurrentUser {
  final AuthRepository _repository;

  GetCurrentUser(this._repository);

  Future<AppUser?> call() async {
    return await _repository.getCurrentUser();
  }
}
