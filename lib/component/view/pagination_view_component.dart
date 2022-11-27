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

  PaginationViewController({
    required this.onLoad,
    this.paginationSize = 20,
  });

  void reset(final BuildContext context) {
    _dataList.clear();
    _isLoading = false;
    _isLoadable = true;
    _pageNumber = 1;

    _update(context);
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

  void _update(final BuildContext context) async {
    if (!_isLoadable) return;

    if (_isLoading) return;

    _isLoading = true;

    final resultList = await onLoad(context, pageNumber);

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
  final EdgeInsets? padding;
  final Axis axis;

  const PaginationViewComponent.list({
    Key? key,
    required this.controller,
    required this.itemBuilder,
    this.axis = Axis.vertical,
    this.padding,
    this.emptyPlaceholder,
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
  }) :  style = PaginationViewStyle.grid,
        super(key: key);

  const PaginationViewComponent.page({
    Key? key,
    required this.controller,
    required this.itemBuilder,
    this.axis = Axis.vertical,
    this.padding,
    this.emptyPlaceholder,
  }) :  style = PaginationViewStyle.page,
        rowCount = 0,
        super(key: key);

  @override
  State<PaginationViewComponent> createState() => _PaginationViewComponentState();
}

class _PaginationViewComponentState extends State<PaginationViewComponent> {
  final _pageController = PageController();
  final _scrollController = ScrollController();

  Widget? get _loadingPlaceholder {
    if (widget.controller.isListEmpty) {
      if (!widget.controller.isLoadable) {
        return widget.emptyPlaceholder;
      }
    }

    return null;
  }

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
    switch(widget.style) {
      case PaginationViewStyle.list:
        return _listStyleComponent;
      case PaginationViewStyle.grid:
        return _gridStyleComponent;
      case PaginationViewStyle.page:
        return _pageStyleComponent;
    }
  }

  Widget get _listStyleComponent {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return _loadingPlaceholder ?? ListView.builder(
          controller: _scrollController,
          itemCount: widget.controller.dataList.length + 1,
          itemBuilder: (context, indexPosition) {
            if (widget.controller.dataList.length > indexPosition) {
              return widget.itemBuilder(context, indexPosition);
            } else if (widget.controller.isLoading) {
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
        );
      },
    );
  }

  Widget get _gridStyleComponent {
    final verticalCount = (widget.controller.dataList.length / widget.rowCount).ceil();
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return _loadingPlaceholder ?? ListView.builder(
          controller: _scrollController,
          itemCount: verticalCount + 1,
          itemBuilder: (context, indexPosition) {
            if (verticalCount > indexPosition) {
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
            } else if (widget.controller.isLoading) {
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
        );
      },
    );
  }

  Widget get _pageStyleComponent {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return _loadingPlaceholder ?? PageView.builder(
          controller: _pageController,
          itemCount: widget.controller.dataList.length,
          itemBuilder: widget.itemBuilder,
        );
      },
    );
  }
}
