import 'package:injectable/injectable.dart';
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/features/entries/domain/repositories/entry_repository.dart';

@injectable
class DeleteEntry {
  final EntryRepository _repository;

  DeleteEntry(this._repository);

  Future<void> call(Entry entry) async {
    await _repository.deleteEntry(entry);
  }
}
