import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class FileUtility {
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

  static Future<File?> captureImage({
    final int? fileQuality,
  }) async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: fileQuality,
    );

    if (imageFile == null) return null;

    return File(imageFile.path);
  }

  static Future<File?> selectImage({
    final int? fileQuality,
  }) async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: fileQuality,
    );

    if (imageFile == null) return null;

    return File(imageFile.path);
  }

  static Future<List<File>> selectImageList({
    final int? fileQuality,
  }) async {
    final imageFileList = await ImagePicker().pickMultiImage(
      imageQuality: fileQuality,
    );

    final fileList = <File> [];

    for (final image in imageFileList) {
      fileList.add(File(image.path));
    }

    return fileList;
  }

  static Future<File?> captureVideo() async {
    final imageFile = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (imageFile == null) return null;

    return File(imageFile.path);
  }

  static Future<File?> selectVideo() async {
    final imageFile = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (imageFile == null) return null;

    return File(imageFile.path);
  }

  const FileUtility._();
}