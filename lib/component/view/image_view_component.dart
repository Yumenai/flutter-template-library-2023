import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

// This image component will fade in image when loaded successfully
class ImageViewComponent extends StatelessWidget {
  final ImageProvider image;
  final Widget? placeholder;
  final Widget? errorPlaceholder;
  final Widget? loadingPlaceholder;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Color? color;
  final BlendMode? colorBlend;

  ImageViewComponent.file(final File file, {
    Key? key,
    this.placeholder,
    this.errorPlaceholder,
    this.loadingPlaceholder,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color,
    this.colorBlend,
  }) :  image = FileImage(file),
        super(key: key);

  ImageViewComponent.asset(final String assetPath, {
    Key? key,
    this.placeholder,
    this.errorPlaceholder,
    this.loadingPlaceholder,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color,
    this.colorBlend,
  }) :  image = AssetImage(assetPath),
        super(key: key);

  ImageViewComponent.memory(Uint8List data, {
    Key? key,
    this.placeholder,
    this.errorPlaceholder,
    this.loadingPlaceholder,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color,
    this.colorBlend,
  }) :  image = MemoryImage(data),
        super(key: key);

  ImageViewComponent.network(final String url, {
    Key? key,
    this.placeholder,
    this.errorPlaceholder,
    this.loadingPlaceholder,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color,
    this.colorBlend,
  }) :  image = NetworkImage(url),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      image: image,
      color: color,
      width: width,
      height: height,
      colorBlendMode: colorBlend,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        final animatedImageWidget = AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: const Duration(
            milliseconds: 250,
          ),
          curve: Curves.easeOut,
          child: child,
        );
        if (wasSynchronouslyLoaded) {
          return animatedImageWidget;
        } else {
          final itemList = [
            if (placeholder is Widget)
              AnimatedOpacity(
                opacity: frame == null ? 1 : 0,
                duration: const Duration(
                  milliseconds: 250,
                ),
                curve: Curves.easeOut,
                child: placeholder,
              ),
            if (loadingPlaceholder is Widget)
              AnimatedOpacity(
                opacity: frame == null ? 1 : 0,
                duration: const Duration(
                  milliseconds: 250,
                ),
                curve: Curves.easeOut,
                child: loadingPlaceholder,
              ),
            animatedImageWidget,
          ];

          if (itemList.length == 1) {
            return itemList.first;
          } else {
            return Stack(
              children: itemList,
            );
          }
        }
      },
      errorBuilder: (context, error, stackTrace) {
        if (placeholder is Widget) {
          return placeholder ?? const SizedBox();
        } else if (errorPlaceholder is Widget) {
          return errorPlaceholder ?? const SizedBox();
        } else {
          /// Put default empty image placeholder
          return LayoutBuilder(
            builder: (context, constraint) {
              final sizeWidth = width ?? constraint.maxWidth;
              final sizeHeight = height ?? constraint.maxHeight;
              return Icon(
                Icons.image_not_supported_outlined,
                size: (sizeWidth > sizeHeight ? sizeHeight : sizeWidth) * 0.5,
              );
            },
          );
        }
      },
    );
  }
}

