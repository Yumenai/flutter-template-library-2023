import 'package:flutter/material.dart';

class ScreenTemplateComponent extends StatelessWidget {
  final String? infoTitle;
  final Widget? infoIconPrefix;
  final Widget? infoIconSuffix;
  final List<Widget>? infoActionList;

  final Widget? layout;
  final Widget? layoutAction;

  final Widget? navigatorLeft;
  final Widget? navigatorRight;
  final Widget? navigatorBottom;

  final bool enableOverlapHeader;

  const ScreenTemplateComponent({
    Key? key,
    this.infoTitle,
    this.infoIconPrefix,
    this.infoIconSuffix,
    this.infoActionList,
    this.layout,
    this.layoutAction,
    this.navigatorLeft,
    this.navigatorRight,
    this.navigatorBottom,
    this.enableOverlapHeader = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _headerLayout(),
        actions: infoActionList,
        backgroundColor: enableOverlapHeader ? Colors.transparent : null,
        elevation: enableOverlapHeader ? 0 : null,
        centerTitle: true,
      ),
      extendBodyBehindAppBar: enableOverlapHeader,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: layout,
      ),
      floatingActionButton: layoutAction,
      drawer: navigatorLeft,
      endDrawer: navigatorRight,
      bottomNavigationBar: navigatorBottom,
    );
  }

  Widget? _headerLayout() {
    final titleWidgetList = <Widget> [];

    if (infoIconPrefix is Widget) {
      titleWidgetList.add(infoIconPrefix ?? const SizedBox());
      titleWidgetList.add(const SizedBox(
        width: 8,
      ));
    }

    if (infoTitle?.isNotEmpty == true) {
      titleWidgetList.add(Text(infoTitle ?? ''));
    }

    if (infoIconSuffix is Widget) {
      titleWidgetList.add(const SizedBox(
        width: 8,
      ));
      titleWidgetList.add(infoIconSuffix ?? const SizedBox());
    }

    if (titleWidgetList.isEmpty) {
      return null;
    } else if (titleWidgetList.length > 1) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: titleWidgetList,
      );
    } else {
      return titleWidgetList.first;
    }
  }
}
