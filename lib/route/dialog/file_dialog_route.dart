import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileDialogRoute {
  static Future<File?> select(final BuildContext context, {
    final String? title,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: title,
    );

    if (result == null) return null;

    if (result.files.isEmpty) return null;

    return File(result.files.first.path ?? '');
  }

  static Future<List<File>> selectList(final BuildContext context, {
    final String? title,
  }) async {
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: title,
      allowMultiple: true,
    );

    if (result == null) return [];

    final fileList = <File> [];

    for (final file in result.files) {
      if (file.path?.isNotEmpty ?? false) {
        fileList.add(File(file.path ?? ''));
      }
    }

    return fileList;
  }

  const FileDialogRoute._();
}