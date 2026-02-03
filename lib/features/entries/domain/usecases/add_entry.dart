import 'package:injectable/injectable.dart';
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/features/entries/domain/repositories/entry_repository.dart';

@injectable
class AddEntry {
  final EntryRepository _repository;

  AddEntry(this._repository);

  Future<void> call(Entry entry) async {
    await _repository.addEntry(entry);
  }
}