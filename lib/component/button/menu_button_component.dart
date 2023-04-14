import 'package:flutter/material.dart';

class MenuButtonComponent extends StatelessWidget {
  final _buttonKey = GlobalKey<PopupMenuButtonState>();

  final List<MenuButtonItem> itemList;

  MenuButtonComponent({
    super.key,
    required this.itemList,
  });

  @override
  Widget build(BuildContext context) {
    MenuButtonItem? model;

    return PopupMenuButton<int>(
      key: _buttonKey,
      itemBuilder: (context) {
        if (model == null) {
          return [
            for (int i = 0; i < itemList.length; i++)
              PopupMenuItem(
                value: i,
                child: Text(itemList[i].title ?? ''),
              ),
          ];
        } else {
          return [
            for (int i = 0; i < (model?.itemList.length ?? 0); i++)
              PopupMenuItem(
                value: i,
                child: Text(model?.itemList[i].title ?? ''),
              ),
          ];
        }
      },
      onSelected: (position) {
        if (model == null) {
          model = itemList[position];
        } else {
          model = model?.itemList[position];
        }

        if (model?.itemList.isEmpty ?? true) {
          model?.onSelect();
          model = null;
        } else {
          _buttonKey.currentState?.showButtonMenu();
        }
      },
      onCanceled: () {
        model = null;
      },
    );
  }
}

class MenuButtonItem {
  final String? title;
  final void Function() onSelect;
  final List<MenuButtonItem> itemList;

  const MenuButtonItem({
    required this.title,
    this.itemList = const [],
    required this.onSelect,
  });
}
