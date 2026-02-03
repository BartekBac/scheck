import 'package:scheck/features/entries/data/models/entry_model.dart';

sealed class EntryChange {}

class EntryInserted extends EntryChange {
  EntryInserted({required this.entry});

  final EntryModel entry;
}

class EntryUpdated extends EntryChange {
  EntryUpdated({required this.entry});

  final EntryModel entry;
}

class EntryDeleted extends EntryChange {
  EntryDeleted({required this.id});

  final String id;
}
