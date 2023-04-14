import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class FileService {
  static final _documentDirectory = getApplicationDocumentsDirectory();
  static final _temporaryDirectory = getTemporaryDirectory();

  static Future<File?> select({
    final String? title,
    final bool allowMultiple = false,
  }) async {
    final file = await FilePicker.platform.pickFiles(
      dialogTitle: title,
      allowMultiple: allowMultiple,
    );

    if (file == null) return null;

    if (file.files.isEmpty) return null;

    final filePath = file.files.first.path;

    if (filePath == null) return null;

    return File(filePath);
  }

  static Future<File?> read(final String? filePath, {
    final bool enableDocumentDirectory = true,
    final bool enableTemporaryDirectory = false,
  }) async {
    if (filePath == null) return null;

    if (filePath.trim().isEmpty) return null;

    final String directoryFilePath;

    if (enableDocumentDirectory) {
      directoryFilePath = '${(await _documentDirectory).path}/$filePath';
    } else if (enableTemporaryDirectory) {
      directoryFilePath = '${(await _temporaryDirectory).path}/$filePath';
    } else {
      directoryFilePath = filePath;
    }

    final file = File(directoryFilePath);

    if (!file.existsSync()) return null;

    return file;
  }

  static Future<File?> write({
    required final List<int> data,
    required final String filePath,
    final bool enableDocumentDirectory = true,
    final bool enableTemporaryDirectory = false,
  }) async {
    final String directoryFilePath;

    if (enableDocumentDirectory) {
      directoryFilePath = '${(await _documentDirectory).path}/$filePath';
    } else if (enableTemporaryDirectory) {
      directoryFilePath = '${(await _temporaryDirectory).path}/$filePath';
    } else {
      directoryFilePath = filePath;
    }

    final fileStorage = File(directoryFilePath);

    final fileFolderList = fileStorage.path.split('/');
    fileFolderList.removeLast();

    if (fileFolderList.isNotEmpty) {
      await _createDirectory(fileFolderList.join('/'));
    }

    try {
      return await fileStorage.writeAsBytes(data);
    } catch(e) {
      log('FileService: set $e');
    }

    return null;
  }

  static Future<void> clearDocumentDirectory() async {
    final documentDirectory = await _documentDirectory;

    await documentDirectory.delete(
      recursive: true,
    );
    await documentDirectory.create(
      recursive: true,
    );
  }

  static Future<void> clearTemporaryDirectory() async {
    final temporaryDirectory = await _temporaryDirectory;

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

  const FileService._();
}
