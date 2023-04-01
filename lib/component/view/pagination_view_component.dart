import 'package:flutter/material.dart';

enum PaginationViewStyle {
  list,
  grid,
  page,
}

class PaginationViewController<T> extends ChangeNotifier {
  final int paginationSize;
  final Future<List<T>> Function(BuildContext, int) onLoad;

  final _dataList = <T> [];
  List<T> get dataList => _dataList;
  bool get isListEmpty => _dataList.isEmpty;

  int _pageNumber = 1;
  int get pageNumber => _pageNumber;

  bool _isLoadable = true;
  bool get isLoadable => _isLoadable;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isInitialise = false;

  PaginationViewController({
    required this.onLoad,
    this.paginationSize = 20,
  });

  Future<void> reset(final BuildContext context) async {
    _dataList.clear();
    _isLoading = false;
    _isLoadable = true;
    _pageNumber = 1;

    await _update(context);
  }

  void add(final T data) {
    _dataList.add(data);
    notifyListeners();
  }

  void addAll(final List<T> dataList) {
    _dataList.addAll(dataList);
    notifyListeners();
  }

  void insert(final int index, final T data) {
    _dataList.insert(index, data);
    notifyListeners();
  }

  void insertAll(final int index, final List<T> dataList) {
    _dataList.insertAll(index, dataList);
    notifyListeners();
  }

  Future<void> _update(final BuildContext context) async {
    if (!_isLoadable) return;

    if (_isLoading) return;

    _isLoading = true;

    if (!_isInitialise) notifyListeners();

    final resultList = await onLoad(context, pageNumber);

    _isInitialise = true;
    _isLoading = false;
    _isLoadable = resultList.length == paginationSize;
    _pageNumber++;

    addAll(resultList);
  }
}

class PaginationViewComponent extends StatefulWidget {
  final PaginationViewController controller;
  final PaginationViewStyle style;
  final int rowCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final Widget? emptyPlaceholder;
  final Widget? initialisePlaceholder;
  final EdgeInsets? padding;
  final Axis axis;
  final bool enableRefreshPull;

  const PaginationViewComponent.list({
    Key? key,
    required this.controller,
    required this.itemBuilder,
    this.axis = Axis.vertical,
    this.padding,
    this.emptyPlaceholder,
    this.initialisePlaceholder,
    this.enableRefreshPull = true,
  }) :  style = PaginationViewStyle.list,
        rowCount = 0,
        super(key: key);

  const PaginationViewComponent.grid({
    Key? key,
    required this.controller,
    required this.rowCount,
    required this.itemBuilder,
    this.axis = Axis.vertical,
    this.padding,
    this.emptyPlaceholder,
    this.initialisePlaceholder,
    this.enableRefreshPull = true,
  }) :  style = PaginationViewStyle.grid,
        super(key: key);

  const PaginationViewComponent.page({
    Key? key,
    required this.controller,
    required this.itemBuilder,
    this.axis = Axis.vertical,
    this.padding,
    this.emptyPlaceholder,
    this.initialisePlaceholder,
    this.enableRefreshPull = true,
  }) :  style = PaginationViewStyle.page,
        rowCount = 0,
        super(key: key);

  @override
  State<PaginationViewComponent> createState() => _PaginationViewComponentState();
}

class _PaginationViewComponentState extends State<PaginationViewComponent> {
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
                if (mounted) {
                  widget.controller._update(context);
                }
              }
            }
          });
          break;
        case PaginationViewStyle.page:
          _pageController.addListener(() {
            if (_pageController.position.atEdge) {
              if (_pageController.position.pixels != 0) {
                if (mounted) {
                  widget.controller._update(context);
                }
              }
            }
          });
          break;
      }

      if (mounted) {
        widget.controller._update(context);
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
        onRefresh: refreshPagination,
        child: component,
      );
    } else {
      return component;
    }
  }

  Future<void> refreshPagination() async {
    if (mounted) {
      await widget.controller.reset(context);
    }
  }

  Widget get _listStyleComponent {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return _initialPlaceholder ?? _emptyPlaceholder ?? ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          itemCount: widget.controller.dataList.length + 1,
          itemBuilder: (context, indexPosition) {
            if (widget.controller.dataList.length > indexPosition) {
              return widget.itemBuilder(context, indexPosition);
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
      },
    );
  }

  Widget get _gridStyleComponent {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        final verticalCount = (widget.controller.dataList.length / widget.rowCount).ceil();

        return  _initialPlaceholder ?? _emptyPlaceholder ?? ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _scrollController,
          itemCount: verticalCount + 1,
          itemBuilder: (context, indexPosition) {
            if (verticalCount > indexPosition) {
              if (widget.axis == Axis.vertical) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(widget.rowCount, (rowPosition) {
                    final itemCount = (indexPosition * widget.rowCount) + rowPosition;

                    if (itemCount < widget.controller.dataList.length) {
                      return Expanded(
                        child: widget.itemBuilder(context, itemCount),
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
                    final itemCount = (indexPosition * widget.rowCount) + rowPosition;

                    if (itemCount < widget.controller.dataList.length) {
                      return Expanded(
                        child: widget.itemBuilder(context, itemCount),
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
      },
    );
  }

  Widget get _pageStyleComponent {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        if (widget.controller._isInitialise) {
          return widget.initialisePlaceholder ?? const SizedBox();
        }

        return _initialPlaceholder ?? _emptyPlaceholder ?? PageView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          controller: _pageController,
          itemCount: widget.controller.dataList.length,
          itemBuilder: widget.itemBuilder,
          scrollDirection: widget.axis,
        );
      },
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
}
