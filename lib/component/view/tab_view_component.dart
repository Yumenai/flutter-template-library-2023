import 'package:flutter/material.dart';

class TabViewComponent extends StatelessWidget {
  final int position;
  final bool isCentered;
  final bool isScrollable;
  final Map<String?, Widget> layout;

  const TabViewComponent({
    super.key,
    this.layout = const {},
    this.position = 0,
    this.isCentered = true,
    this.isScrollable = true,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: position,
      length: layout.length,
      child: Column(
        crossAxisAlignment: isCentered ? CrossAxisAlignment.center : CrossAxisAlignment.stretch,
        children: [
          TabBar(
            isScrollable: isScrollable,
            labelColor: Theme.of(context).colorScheme.onSurface,
            tabs: layout.keys.map((title) {
              return Tab(
                text: title ?? '',
              );
            }).toList(),
          ),
          Expanded(
            child: TabBarView(
              children: layout.values.toList(),
            ),
          ),
        ],
      ),
    );
  }
}


class PageTabViewComponent extends StatelessWidget {
  final int position;
  final Map<String?, Widget> layout;

  const PageTabViewComponent({
    super.key,
    this.layout = const {},
    this.position = 0,
  });

  @override
  Widget build(BuildContext context) {
    const tabHorizontalSpacing = 24.0;
    int currentPagePosition = position;

    if (layout.isEmpty) return const SizedBox();

    return LayoutBuilder(
      builder: (context, constraint) {
        final itemWidth = (constraint.constrainWidth() / layout.length) - tabHorizontalSpacing;
        return StatefulBuilder(
          builder: (context, setState) {
            final titleTextList = <Widget> [];
            final contentLayoutList = <Widget> [];

            for (int i = 0; i < layout.entries.length; i++) {
              final entry = layout.entries.elementAt(i);

              titleTextList.add(Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: const RoundedRectangleBorder(),
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(double.infinity, double.infinity),
                    foregroundColor: currentPagePosition == i ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
                    backgroundColor: Colors.transparent,
                  ),
                  child: Text(
                    entry.key ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  onPressed: () {
                    currentPagePosition = i;
                    setState(() {});
                  },
                ),
              ));
              contentLayoutList.add(entry.value);
            }

            return Column(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(Radius.circular(999)),
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: tabHorizontalSpacing,
                    vertical: 12,
                  ),
                  height: kToolbarHeight * 0.75,
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.center,
                    children: [
                      AnimatedPositioned(
                        duration: const Duration(
                          milliseconds: 150,
                        ),
                        top: 0,
                        left: itemWidth * currentPagePosition,
                        bottom: 0,
                        child:  Container(
                          color: Theme.of(context).colorScheme.primary,
                          width: itemWidth,
                          height: 10,
                        ),
                      ),
                      Row(
                        children: titleTextList,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: IndexedStack(
                    index: currentPagePosition,
                    children: contentLayoutList,
                  ),
                ),
              ],
            );
          },
        );
      }
    );
  }
}
