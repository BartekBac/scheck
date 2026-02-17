import 'package:injectable/injectable.dart';
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/features/entries/domain/repositories/entry_repository.dart';

@injectable
class WatchEntries {
  final EntryRepository _repository;

  WatchEntries(this._repository);

  Stream<List<Entry>> call() {
    return _repository.watchAll();
  }
}
