import 'dart:io';

import 'package:image_picker/image_picker.dart';

class MediaUtility {
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

  const MediaUtility._();
}