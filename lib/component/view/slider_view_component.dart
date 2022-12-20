import 'dart:async';

import 'package:flutter/material.dart';

class SliderViewComponent extends StatefulWidget {
  final int? itemCount;
  final Widget Function(BuildContext, int)? itemBuilder;
  final List<Widget> children;
  final Color? indicatorColor;
  final Duration? automateDuration;

  const SliderViewComponent({
    Key? key,
    this.children = const [],
    this.indicatorColor,
    this.automateDuration,
  }) :  itemCount = null,
        itemBuilder = null,
        super(key: key);

  const SliderViewComponent.builder({
    Key? key,
    this.itemCount,
    this.itemBuilder,
    this.indicatorColor,
    this.automateDuration,
  }) :  children = const [],
        super(key: key);

  @override
  State<SliderViewComponent> createState() => _SliderViewComponentState();
}

class _SliderViewComponentState extends State<SliderViewComponent> {
  final model = _SliderViewModel();
  final pageController = PageController();
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
    return Stack(
      children: [
        if (widget.itemCount == null)
          PageView(
            controller: pageController,
            onPageChanged: (position) {
              model.updatePosition(position);
            },
            children: widget.children,
          )
        else
          PageView.builder(
            controller: pageController,
            onPageChanged: (position) {
              model.updatePosition(position);
            },
            itemCount: widget.itemCount,
            itemBuilder: (context, indexPosition) {
              return widget.itemBuilder?.call(context, indexPosition) ?? const SizedBox();
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
