import 'dart:async';

import 'package:flutter/material.dart';

class SliderViewComponent extends StatefulWidget {
  final int? itemCount;
  final Widget Function(BuildContext, int)? itemBuilder;
  final List<Widget> children;
  final Color? indicatorColor;
  final Duration? automateDuration;
  final bool enableWindowMode;
  final bool enableAnimation;

  const SliderViewComponent({
    Key? key,
    this.children = const [],
    this.indicatorColor,
    this.automateDuration,
    this.enableWindowMode = false,
    this.enableAnimation = true,
  }) :  itemCount = null,
        itemBuilder = null,
        super(key: key);

  const SliderViewComponent.builder({
    Key? key,
    this.itemCount,
    this.itemBuilder,
    this.indicatorColor,
    this.automateDuration,
    this.enableWindowMode = false,
    this.enableAnimation = true,
  }) :  children = const [],
        super(key: key);

  @override
  State<SliderViewComponent> createState() => _SliderViewComponentState();
}

class _SliderViewComponentState extends State<SliderViewComponent> {
  final model = _SliderViewModel();
  late final pageController = PageController(
    viewportFraction: widget.enableWindowMode ? 0.7 : 1,
  );
  late final Timer timer;

  @override
  void initState() {
    if (widget.automateDuration != null) {
      timer = Timer.periodic(widget.automateDuration ?? const Duration(seconds: 1), (timer) {
        if (model.pagePosition == (widget.itemCount ?? widget.children.length) - 1) {
          pageController.jumpTo(0);
        } else {
          pageController.nextPage(
            duration: const Duration(
              milliseconds: 150,
            ),
            curve: Curves.linear,
          );
        }
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    model.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final constantItemSize = widget.itemCount ?? widget.children.length;

    return Stack(
      children: [
        PageView.builder(
          controller: pageController,
          onPageChanged: (position) {
            model.updatePosition(position % constantItemSize);
          },
          itemBuilder: (context, indexPosition) {
            final constantPosition = indexPosition % constantItemSize;
            final itemWidget = widget.itemBuilder?.call(context, constantPosition) ?? (widget.children.length > constantPosition ? widget.children[constantPosition] : const SizedBox());

            if (widget.enableAnimation) {
              return AnimatedBuilder(
                animation: model,
                child: itemWidget,
                builder: (context, child) {
                  return AnimatedPadding(
                    padding: model.pagePosition == constantPosition ? const EdgeInsets.all(0) : const EdgeInsets.all(24),
                    curve: Curves.easeInOutCubic,
                    duration: const Duration(
                      milliseconds: 250,
                    ),
                    child: child,
                  );
                },
              );
            } else {
              return itemWidget;
            }
          },
        ),
        Positioned(
          left: 12,
          right: 12,
          bottom: 8,
          child: Wrap(
            alignment: WrapAlignment.center,
            children: List.generate(widget.itemCount ?? widget.children.length, (indexPosition) {
              return _indicatorItem(indexPosition);
            }),
          ),
        ),
      ],
    );
  }

  Widget _indicatorItem(final int pagePosition) {
    return AnimatedBuilder(
      animation: model,
      builder: (context, child) {
        return AnimatedContainer(
          duration: const Duration(
            milliseconds: 150,
          ),
          margin: const EdgeInsets.symmetric(
            horizontal: 4,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(99),
            ),
            color: widget.indicatorColor ?? Theme.of(context).colorScheme.primary,
          ),
          height: 10,
          width: model.pagePosition == pagePosition ? 30 : 10,
        );
      },
    );
  }
}

class _SliderViewModel extends ChangeNotifier {
  int pagePosition = 0;

  void updatePosition(final int position) {
    pagePosition = position;

    notifyListeners();
  }
}
