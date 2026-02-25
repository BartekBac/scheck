import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'dart:developer' as d;

import 'package:supabase_flutter/supabase_flutter.dart';

@LazySingleton()
class ImageService {
  ImageService(this._client);

  static const String tableName = 'entries';
  static const String bucketName = 'meal-images';
  final SupabaseClient _client;

  String get emptyImageUrl => _client.storage.from(bucketName).getPublicUrl('$bucketName/empty-meal.jpg');

  Future<File> compressImage(File file, {int quality = 40, int minWidth = 540, int minHeight = 540}) async {
    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;
    final fileName = p.basename(file.path);
    final outPath = p.join(path, "compressed_$fileName");

    final XFile? compressedXFile = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: quality,
      minWidth: minWidth,
      minHeight: minHeight,
    );

    if (compressedXFile == null) {
      // if compression fails. return original file
      d.log('Error: Image compression failed, returning source file.');
      return file;
    }

    return File(compressedXFile.path);
  }
}