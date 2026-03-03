import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:scheck/features/entries/domain/repositories/entry_repository.dart';

@injectable
class UploadImage {
  final EntryRepository _repository;

  UploadImage(this._repository);

  Future<String> call(File image, String userId, String entryId) async {
    return _repository.uploadImage(image, userId, entryId);
  }
}