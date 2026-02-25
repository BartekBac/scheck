import 'package:injectable/injectable.dart';
import 'package:scheck/features/entries/domain/repositories/entry_repository.dart';

@injectable
class DeleteImage {
  final EntryRepository _repository;

  DeleteImage(this._repository);

  Future<void> call(String userId, String entryId) async {
    return _repository.deleteImage(userId, entryId);
  }
}