import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../controller/app_controller.dart';
import '../../data/resource/color_resource_data.dart';
import '../../data/resource/language_resource_data.dart';

class AppTemplateComponent extends StatefulWidget {
  final String name;
  final Widget layout;

  const AppTemplateComponent({
    Key? key,
    required this.name,
    required this.layout,
  }) : super(key: key);

  @override
  State<AppTemplateComponent> createState() => _AppTemplateComponentState();
}

class _AppTemplateComponentState extends State<AppTemplateComponent> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    if (mounted) {
      if (AppController.of(context).themeMode == ThemeMode.system) {
        AppController.of(context).updateBrightness(WidgetsBinding.instance.window.platformBrightness);
      } else {
        AppController.of(context).updateBrightness(Theme.of(context).brightness);
      }
    }

    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    const darkColorResource = ColorResourceData.dark();
    const lightColorResource = ColorResourceData.light();

    final SystemUiOverlayStyle systemUiOverlayStyle;

    if (Theme.of(context).brightness == Brightness.dark) {
      systemUiOverlayStyle = SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: darkColorResource.system,
        systemNavigationBarDividerColor: darkColorResource.system,
        statusBarColor: darkColorResource.system,
      );
    } else {
      systemUiOverlayStyle = SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: lightColorResource.system,
        systemNavigationBarDividerColor: lightColorResource.system,
        statusBarColor: lightColorResource.system,
      );
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: systemUiOverlayStyle,
      child: MaterialApp(
        title: widget.name,
        home: widget.layout,
        themeMode: AppController.listen(context).themeMode,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          primaryColor: lightColorResource.primary,
          colorScheme: ColorScheme.light(
            brightness: Brightness.light,
            primary: lightColorResource.primary,
            onPrimary: lightColorResource.onPrimary,
            secondary: lightColorResource.secondary,
            onSecondary: lightColorResource.onSecondary,
            error: lightColorResource.error,
            onError: lightColorResource.onError,
            background: lightColorResource.background,
            onBackground: lightColorResource.onBackground,
            surface: lightColorResource.surface,
            onSurface: lightColorResource.onSurface,
          ),
          radioTheme: RadioThemeData(
            fillColor: MaterialStateProperty.all(lightColorResource.primary),
          ),
          checkboxTheme: CheckboxThemeData(
            checkColor: MaterialStateProperty.all(lightColorResource.primary),
          ),
        ),
        darkTheme: ThemeData.dark(
          useMaterial3: true,
        ).copyWith(
          primaryColor: darkColorResource.primary,
          colorScheme: ColorScheme.dark(
            brightness: Brightness.dark,
            primary: darkColorResource.primary,
            onPrimary: darkColorResource.onPrimary,
            secondary: darkColorResource.secondary,
            onSecondary: darkColorResource.onSecondary,
            error: darkColorResource.error,
            onError: darkColorResource.onError,
            background: darkColorResource.background,
            onBackground: darkColorResource.onBackground,
            surface: darkColorResource.surface,
            onSurface: darkColorResource.onSurface,
          ),
          radioTheme: RadioThemeData(
            fillColor: MaterialStateProperty.all(darkColorResource.primary),
          ),
          checkboxTheme: CheckboxThemeData(
            checkColor: MaterialStateProperty.all(darkColorResource.primary),
          ),
        ),
        locale: AppController.listen(context).locale,
        supportedLocales: LanguageResourceData.supportedLocaleList,
        localizationsDelegates: LanguageResourceData.localizationDelegateList,
      ),
    );
  }
}
