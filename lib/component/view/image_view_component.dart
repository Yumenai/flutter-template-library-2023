import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

// This image component will fade in image when loaded successfully
class ImageViewComponent extends StatelessWidget {
  final ImageProvider image;
  final Widget? errorPlaceholder;
  final Widget? loadingPlaceholder;
  final double? width;
  final double? height;
  final double? aspectRatio;
  final BoxFit? fit;
  final Color? color;
  final BlendMode? colorBlend;

  ImageViewComponent.file(final File file, {
    super.key,
    this.errorPlaceholder,
    this.loadingPlaceholder,
    this.width,
    this.height,
    this.aspectRatio,
    this.fit = BoxFit.cover,
    this.color,
    this.colorBlend,
  }) :  image = FileImage(file);

  ImageViewComponent.asset(final String assetPath, {
    super.key,
    this.errorPlaceholder,
    this.loadingPlaceholder,
    this.width,
    this.height,
    this.aspectRatio,
    this.fit = BoxFit.cover,
    this.color,
    this.colorBlend,
  }) :  image = AssetImage(assetPath);

  ImageViewComponent.memory(final Uint8List data, {
    super.key,
    this.errorPlaceholder,
    this.loadingPlaceholder,
    this.width,
    this.height,
    this.aspectRatio,
    this.fit = BoxFit.cover,
    this.color,
    this.colorBlend,
  }) :  image = MemoryImage(data);

  ImageViewComponent.network(final String url, {
    super.key,
    this.errorPlaceholder,
    this.loadingPlaceholder,
    this.width,
    this.height,
    this.aspectRatio,
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
      width: width,
      height: height,
      colorBlendMode: colorBlend,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) {
          return _sizeAdjustment(child);
        } else {
          return AnimatedCrossFade(
            firstChild: _sizeAdjustment(loadingPlaceholder ?? const _ImageLoadingPlaceholder()),
            secondChild: _sizeAdjustment(child),
            crossFadeState: frame == null ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: const Duration(
              milliseconds: 500,
            ),
          );
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
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: errorPlaceholder,
                ),
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

  Widget _sizeAdjustment(Widget child) {
    if (aspectRatio != null) {
      child = AspectRatio(
        aspectRatio: aspectRatio ?? 1,
        child: child,
      );
    }

    if (width != null || height != null) {
      child = SizedBox(
        height: height,
        width: width,
        child: child,
      );
    }

    return child;
  }
}

class _ImageLoadingPlaceholder extends StatefulWidget {
  const _ImageLoadingPlaceholder();

  @override
  State<_ImageLoadingPlaceholder> createState() => _ImageLoadingPlaceholderState();
}

class _ImageLoadingPlaceholderState extends State<_ImageLoadingPlaceholder> {
  double opacity = 1;
  Timer? timer;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      timer ??= Timer.periodic(const Duration(milliseconds: 500), (timer) {
        if (opacity == 1) {
          opacity = 0.5;
        } else {
          opacity = 1;
        }
        if (mounted) {
          setState(() {});
        } else {
          timer.cancel();
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(
        milliseconds: 500,
      ),
      curve: Curves.linear,
      child: Container(
        color: Theme.of(context).brightness == Brightness.dark ? const Color(0xFF616161) : const Color(0xFFE0E0E0),
      ),
    );
  }
}
