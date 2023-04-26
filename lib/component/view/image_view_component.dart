import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

// This image component will fade in image when loaded successfully
class ImageViewComponent extends StatelessWidget {
  final ImageProvider image;
  final Widget? errorPlaceholder;
  final BoxFit? fit;
  final Color? color;
  final BlendMode? colorBlend;

  ImageViewComponent.file(final File file, {
    super.key,
    this.errorPlaceholder,
    this.fit = BoxFit.cover,
    this.color,
    this.colorBlend,
  }) :  image = FileImage(file);

  ImageViewComponent.asset(final String assetPath, {
    super.key,
    this.errorPlaceholder,
    this.fit = BoxFit.cover,
    this.color,
    this.colorBlend,
  }) :  image = AssetImage(assetPath);

  ImageViewComponent.memory(final Uint8List data, {
    super.key,
    this.errorPlaceholder,
    this.fit = BoxFit.cover,
    this.color,
    this.colorBlend,
  }) :  image = MemoryImage(data);

  ImageViewComponent.network(final String url, {
    super.key,
    this.errorPlaceholder,
    this.fit = BoxFit.cover,
    this.color,
    this.colorBlend,
  }) :  image = NetworkImage(url);

  @override
  Widget build(BuildContext context) {
    return Image(
      fit: fit,
      image: image,
      color: color,
      colorBlendMode: colorBlend,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        // Assuming only network image require loading animation
        if (image is NetworkImage) {
          if (wasSynchronouslyLoaded) {
            return child;
          } else {
            return AnimatedOpacity(
              opacity: frame == null ? 0 : 1,
              duration: const Duration(
                milliseconds: 250,
              ),
              child: child,
            );
          }
        } else {
          return child;
        }
      },
      errorBuilder: (context, error, stackTrace) {
        if (errorPlaceholder is Widget) {
          return FutureBuilder(
            future: Future.delayed(const Duration(milliseconds: 250)),
            builder: (context, asyncSnapshot) {
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 250),
                opacity: asyncSnapshot.connectionState == ConnectionState.done ? 1 : 0,
                child: errorPlaceholder ?? const Placeholder(),
              );
            },
          );
        } else {
          /// Put default empty image placeholder
          if (Theme.of(context).brightness == Brightness.dark) {
            return Container(
              color: const Color(0xFF424242),
            );
          } else {
            return Container(
              color: const Color(0xFFEEEEEE),
            );
          }
        }
      },
    );
  }
}
