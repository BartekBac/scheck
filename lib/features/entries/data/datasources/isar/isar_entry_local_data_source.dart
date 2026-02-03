import 'package:isar/isar.dart';
import 'package:scheck/features/entries/data/datasources/entry_local_data_source.dart';
import 'package:scheck/features/entries/data/datasources/isar/collections/entry_collection.dart';
import 'package:scheck/features/entries/data/datasources/isar/collections/entry_collection_mapper.dart';
import 'package:scheck/features/entries/data/models/entry_model.dart';

class IsarEntityLocalDataSource
    implements EntryLocalDataSource {
  final Isar isar;

  IsarEntityLocalDataSource(this.isar);
  
  @override
  Stream<List<EntryModel>> watchAll() {
    return isar.collection<EntryCollection>() //.entityIsars
        .where()
        //.sortByUpdatedAtDesc()
        .watch(fireImmediately: true)
        .map((entries) => entries.map((e) => e.toModel()).toList(),
    );
  }

  @override
  Future<void> upsertAll(List<EntryModel> entries) async {
    await isar.writeTxn(() async {
      await isar.collection<EntryCollection>().putAll(
        entries.map(toCollection).toList(),
      );
    });
  }

  @override
  Future<void> insert(EntryModel entry) async {
    await isar.writeTxn(() async {
      await isar.collection<EntryCollection>().put(toCollection(entry));
    });
  }

  @override
  Future<void> delete(String id) async {
    await isar.writeTxn(() async {
      final toDelete = await isar.collection<EntryCollection>()
          .buildQuery<EntryCollection>(
        filter: FilterCondition(
            type: FilterConditionType.equalTo,
            property: 'id',
            value1: id,
            include1: true,
            include2: false,
            caseSensitive: false
        )
      ).findAll();
      /*
      final toDelete = await isar.collection<EntryCollection>()
          .filter()
          .idEqualTo(id)
          .findAll();
      */
      await isar.collection<EntryCollection>().deleteAll(
        toDelete.map((e) => e.isarId).toList(),
      );
    });
  }
}
