import 'package:flutter/material.dart';

enum PaginationViewStyle {
  list,
  grid,
  page,
}

class PaginationViewModel<T> {
  final T model;
  final int position;

  const PaginationViewModel({
    required this.model,
    required this.position,
  });
}

class PaginationViewController<T>  {
  final viewKey = GlobalKey<_PaginationViewComponentState>();
  final int paginationSize;

  final _dataList = <T> [];
  List<T> get dataList => _dataList;
  bool get isListEmpty => _dataList.isEmpty;

  int _pageNumber = 1;
  int get pageNumber => _pageNumber;

  bool _isLoadable = true;
  bool get isLoadable => _isLoadable;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  PaginationViewController({
    this.paginationSize = 20,
  });

  Future<void> reset(final BuildContext context) async {
    _dataList.clear();
    _isLoading = false;
    _isLoadable = true;
    _pageNumber = 1;

    await viewKey.currentState?.getDataList();
  }

  Future<void> rebuild(final BuildContext context) async {
    await viewKey.currentState?.rebuild();
  }
}

class PaginationViewComponent<T> extends StatefulWidget {
  final PaginationViewController<T> controller;
  final PaginationViewStyle style;
  final int rowCount;
  final Widget Function(BuildContext, PaginationViewModel<T>) itemBuilder;
  final Future<List<T>> Function(BuildContext, int) onLoad;
  final Widget? emptyPlaceholder;
  final Widget? initialisePlaceholder;
  final EdgeInsets? padding;
  final Axis axis;
  final bool enableRefreshPull;

  PaginationViewComponent.list({
    required this.controller,
    required this.itemBuilder,
    required this.onLoad,
    this.axis = Axis.vertical,
    this.padding,
    this.emptyPlaceholder,
    this.initialisePlaceholder,
    this.enableRefreshPull = true,
  }) :  style = PaginationViewStyle.list,
        rowCount = 0,
        super(key: controller.viewKey);

  PaginationViewComponent.grid({
    required this.controller,
    required this.rowCount,
    required this.itemBuilder,
    required this.onLoad,
    this.axis = Axis.vertical,
    this.padding,
    this.emptyPlaceholder,
    this.initialisePlaceholder,
    this.enableRefreshPull = true,
  }) :  style = PaginationViewStyle.grid,
        super(key: controller.viewKey);

  PaginationViewComponent.page({
    Key? key,
    required this.controller,
    required this.itemBuilder,
    required this.onLoad,
    this.axis = Axis.vertical,
    this.padding,
    this.emptyPlaceholder,
    this.initialisePlaceholder,
    this.enableRefreshPull = true,
  }) :  style = PaginationViewStyle.page,
        rowCount = 0,
        super(key: controller.viewKey);

  @override
  State<PaginationViewComponent> createState() => _PaginationViewComponentState<T>();
}

class _PaginationViewComponentState<T> extends State<PaginationViewComponent<T>> {
  final _pageController = PageController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      switch(widget.style) {
        case PaginationViewStyle.list:
        case PaginationViewStyle.grid:
          _scrollController.addListener(() {
            if (_scrollController.position.atEdge) {
              if (_scrollController.position.pixels != 0) {
                getDataList();
              }
            }
          });
          break;
        case PaginationViewStyle.page:
          _pageController.addListener(() {
            if (_pageController.position.atEdge) {
              if (_pageController.position.pixels != 0) {
                getDataList();
              }
            }
          });
          break;
      }

      if (mounted) {
        getDataList();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Widget component;
    switch(widget.style) {
      case PaginationViewStyle.list:
        component = _listStyleComponent;
        break;
      case PaginationViewStyle.grid:
        component = _gridStyleComponent;
        break;
      case PaginationViewStyle.page:
        component = _pageStyleComponent;
        break;
    }

    if (widget.enableRefreshPull) {
      return RefreshIndicator(
        onRefresh: () async {
          if (mounted) {
            await widget.controller.reset(context);
          }
        },
        child: _initialPlaceholder ?? _emptyPlaceholder ?? component,
      );
    } else {
      return _initialPlaceholder ?? _emptyPlaceholder ?? component;
    }
  }

  Widget get _listStyleComponent {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      itemCount: widget.controller.dataList.length + 1,
      itemBuilder: (context, position) {
        if (widget.controller.dataList.length > position) {
          return widget.itemBuilder(
            context,
            PaginationViewModel(
              model: widget.controller.dataList[position],
              position: position,
            ),
          );
        } else if (widget.controller.isLoadable) {
          return const Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
      padding: widget.padding,
      scrollDirection: widget.axis,
    );
  }

  Widget get _gridStyleComponent {
    final verticalCount = (widget.controller.dataList.length / widget.rowCount).ceil();

    return  ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _scrollController,
      itemCount: verticalCount + 1,
      itemBuilder: (context, position) {
        if (verticalCount > position) {
          if (widget.axis == Axis.vertical) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(widget.rowCount, (rowPosition) {
                final itemCount = (position * widget.rowCount) + rowPosition;

                if (itemCount < widget.controller.dataList.length) {
                  return Expanded(
                    child: widget.itemBuilder(
                      context,
                      PaginationViewModel(
                        model: widget.controller.dataList[itemCount],
                        position: itemCount,
                      ),
                    ),
                  );
                } else {
                  return const Expanded(
                    child: SizedBox(),
                  );
                }
              },),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(widget.rowCount, (rowPosition) {
                final itemCount = (position * widget.rowCount) + rowPosition;

                if (itemCount < widget.controller.dataList.length) {
                  return Expanded(
                    child: widget.itemBuilder(
                      context,
                      PaginationViewModel(
                        model: widget.controller.dataList[position],
                        position: position,
                      ),
                    ),
                  );
                } else {
                  return const Expanded(
                    child: SizedBox(),
                  );
                }
              },),
            );
          }
        } else if (widget.controller.isLoadable) {
          return const Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
      padding: widget.padding,
      scrollDirection: widget.axis,
    );
  }

  Widget get _pageStyleComponent {
    return PageView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      controller: _pageController,
      itemCount: widget.controller.dataList.length,
      itemBuilder: (context, position) {
        return widget.itemBuilder(
          context,
          PaginationViewModel(
            model: widget.controller.dataList[position],
            position: position,
          ),
        );
      },
      scrollDirection: widget.axis,
    );
  }

  Widget? get _emptyPlaceholder {
    if (widget.controller.isListEmpty) {
      if (!widget.controller.isLoadable) {
        return widget.emptyPlaceholder;
      }
    }

    return null;
  }

  Widget? get _initialPlaceholder {
    if (widget.controller.isListEmpty) {
      if (widget.controller.isLoading) {
        return widget.initialisePlaceholder;
      }
    }

    return null;
  }

  Future<void> rebuild() async {
    if (mounted) setState(() {});
  }

  Future<void> getDataList() async {
    if (!widget.controller.isLoadable) return;

    if (widget.controller.isLoading) return;

    widget.controller._isLoading = true;

    final resultList = await widget.onLoad(context, widget.controller.pageNumber);

    widget.controller._isLoading = false;
    widget.controller._isLoadable = resultList.length >= widget.controller.paginationSize;
    widget.controller._pageNumber++;

    widget.controller._dataList.addAll(resultList);

    rebuild();
  }
}
