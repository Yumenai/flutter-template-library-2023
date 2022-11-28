import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileStorageUtility {
  static Directory? _documentDirectory;
  static Directory? _temporaryDirectory;

  static Future<Directory> get _instanceDocumentDirectory async {
    return _documentDirectory ??= await getApplicationDocumentsDirectory();
  }

  static Future<Directory> get _instanceTemporaryDirectory async {
    return _temporaryDirectory ??= await getTemporaryDirectory();
  }

  static Future<File?> set({
    required final List<int> data,
    required final String filePath,
    final bool isTemporary = false,
  }) async {
    final directory = isTemporary ? await _instanceTemporaryDirectory : await _instanceDocumentDirectory;

    final fileStorage = File('${directory.path}/$filePath');

    final fileFolderList = filePath.split('/');

    if (fileFolderList.length > 1) {
      fileFolderList.removeLast();

      await _createDirectory('${directory.path}/${fileFolderList.join('/')}');
    } else {
      await _createDirectory(directory.path);
    }

    try {
      return await fileStorage.writeAsBytes(data);
    } catch(e) {
      log('FileRepositoryService: set $e');
    }

    return null;
  }

  static File? get(final String? filePath) {
    if (filePath == null) return null;

    if (filePath.trim().isEmpty) return null;

    final file = File(filePath);

    if (!file.existsSync()) return null;

    return file;
  }

  static Future<void> clearDocumentDirectory() async {
    final documentDirectory = await _instanceDocumentDirectory;

    await documentDirectory.delete(
      recursive: true,
    );
    await documentDirectory.create(
      recursive: true,
    );
  }

  static Future<void> clearTemporaryDirectory() async {
    final temporaryDirectory = await _instanceTemporaryDirectory;

    await temporaryDirectory.delete(
      recursive: true,
    );
    await temporaryDirectory.create(
      recursive: true,
    );
  }

  static Future<void> clearAll() async {
    await clearDocumentDirectory();
    await clearTemporaryDirectory();
  }

  static Future<void> _createDirectory(final String directoryPath) async {
    final directory = Directory(directoryPath);

    if (await directory.exists()) return;

    await directory.create(
      recursive: true,
    );
  }

  const FileStorageUtility._();
}
