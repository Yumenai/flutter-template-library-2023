import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';


class FileRepositoryService {
  static Future<FileRepositoryService> setup({
    final bool clearDocumentDirectory = false,
    final bool clearTemporaryDirectory = false,
  }) async {
    final documentDirectory = await getApplicationDocumentsDirectory();
    final temporaryDirectory = await getTemporaryDirectory();

    if (clearDocumentDirectory) {
      await documentDirectory.delete(
        recursive: true,
      );
      await documentDirectory.create(
        recursive: true,
      );
    }

    if (clearTemporaryDirectory) {
      await temporaryDirectory.delete(
        recursive: true,
      );
      await temporaryDirectory.create(
        recursive: true,
      );
    }

    return FileRepositoryService._(
      documentDirectory: documentDirectory,
      temporaryDirectory: temporaryDirectory,
    );
  }

  final Directory documentDirectory;
  final Directory temporaryDirectory;

  FileRepositoryService._({
    required this.documentDirectory,
    required this.temporaryDirectory,
  });

  Future<void> clear() async {
    await documentDirectory.delete();
    await temporaryDirectory.delete();
  }

  Future<File?> set({
    required final List<int> data,
    required final String filePath,
  }) async {
    final fileStorage = File('${documentDirectory.path}/$filePath');

    final fileFolderList = filePath.split('/');

    if (fileFolderList.length > 1) {
      fileFolderList.removeLast();

      await Directory('${documentDirectory.path}/${fileFolderList.join('/')}').create(
        recursive: true,
      );
    }

    try {
      return await fileStorage.writeAsBytes(data);
    } catch(e) {
      log('FileRepositoryService: set $e');
    }

    return null;
  }

  File? get(final String? filePath) {
    if (filePath == null) return null;

    if (filePath.trim().isEmpty) return null;

    final file = File(filePath);

    if (!file.existsSync()) return null;

    return file;
  }
}
