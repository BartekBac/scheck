import 'package:injectable/injectable.dart';
import 'package:scheck/core/entities/entry.dart';
import 'package:scheck/features/entries/domain/repositories/entry_repository.dart';

@injectable
class GetEntries {
  final EntryRepository repository;

  GetEntries(this.repository);

  Future<List<Entry>> call() async {
    return await repository.getEntries();
  }
}