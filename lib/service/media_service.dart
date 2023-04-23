import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utility/dialog_utility.dart';

class MediaService {
  static Future<File?> selectImage(final BuildContext context, {
    final String title = '',
  }) async {
    final selectedOptionPosition = await DialogUtility.showOptionSelector(
      context,
      title: title.isEmpty ? 'Select Image' : title,
      optionList: [
        'Camera',
        'Gallery',
      ],
    );

    if (selectedOptionPosition == 0) {
      return getCameraImage();
    } else if (selectedOptionPosition == 1) {
      return getGalleryImage();
    } else {
      return null;
    }
  }

  static Future<File?> selectVideo(final BuildContext context, {
    final String title = '',
  }) async {
    final selectedOptionPosition = await DialogUtility.showOptionSelector(
      context,
      title: title.isEmpty ? 'Select Video' : title,
      optionList: [
        'Camera',
        'Gallery',
      ],
    );

    if (selectedOptionPosition == 0) {
      return getCameraVideo();
    } else if (selectedOptionPosition == 1) {
      return getGalleryVideo();
    } else {
      return null;
    }
  }

  static Future<File?> getCameraImage({
    final int? fileQuality,
  }) async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.camera,
      imageQuality: fileQuality,
    );

    if (imageFile == null) return null;

    return File(imageFile.path);
  }

  static Future<File?> getCameraVideo() async {
    final imageFile = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (imageFile == null) return null;

    return File(imageFile.path);
  }

  static Future<File?> getGalleryImage({
    final int? fileQuality,
  }) async {
    final imageFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: fileQuality,
    );

    if (imageFile == null) return null;

    return File(imageFile.path);
  }

  static Future<List<File>> getGalleryImageList({
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

  static Future<File?> getGalleryVideo() async {
    final imageFile = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );

    if (imageFile == null) return null;

    return File(imageFile.path);
  }

  const MediaService._();
}