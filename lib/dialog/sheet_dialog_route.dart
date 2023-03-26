import 'package:flutter/material.dart';

class SheetDialogRoute {
  static Future<dynamic> show(final BuildContext context, {
    final List<Widget>? children,
    final bool isScrollable = false,
  }) async {
    return showModalBottomSheet(
      context: context,
      clipBehavior: Clip.antiAlias,
      isScrollControlled: isScrollable,
      builder: (context) {
        if (isScrollable) {
          return DraggableScrollableSheet(
            snap: true,
            expand: false,
            maxChildSize: 0.85,
            minChildSize: 0.5,
            builder: (context, scrollController) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(99)),
                    ),
                    margin: const EdgeInsets.all(12),
                    height: 10,
                    width: 100,
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: 100,
                      itemBuilder: (context, index) => ListTile(title: Text('Test $index'), onTap: () {},),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(99)),
                ),
                margin: const EdgeInsets.all(12),
                height: 10,
                width: 100,
              ),
              ...?children,
            ],
          );
        }
      },
    );
  }

  static Future<dynamic> showPersistent(final BuildContext context, {
    final List<Widget>? children,
    final bool isScrollable = false,
  }) async {
    final result = showBottomSheet(
      context: context,
      clipBehavior: Clip.antiAlias,
      builder: (context) {
        if (isScrollable) {
          return DraggableScrollableSheet(
            snap: true,
            expand: false,
            maxChildSize: 0.7,
            builder: (context, scrollController) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(99)),
                    ),
                    margin: const EdgeInsets.all(12),
                    height: 10,
                    width: 100,
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: 100,
                      itemBuilder: (context, index) => ListTile(title: Text('Test $index'), onTap: () {},),
                    ),
                  ),
                ],
              );
            },
          );
        } else {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(99)),
                ),
                margin: const EdgeInsets.all(12),
                height: 10,
                width: 100,
              ),
              ...?children,
            ],
          );
        }
      },
    );
    // final result = showBottomSheet(
    //   context: context,
    //   clipBehavior: Clip.antiAlias,
    //   builder: (context) {
    //     return Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Container(
    //           decoration: const BoxDecoration(
    //             color: Colors.grey,
    //             borderRadius: BorderRadius.all(Radius.circular(99)),
    //           ),
    //           margin: const EdgeInsets.all(12),
    //           height: 10,
    //           width: 100,
    //         ),
    //         ...?children,
    //       ],
    //     );
    //   },
    // );

    return result.closed;
  }
}
