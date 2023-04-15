import 'package:flutter/material.dart';

import '../../provider/app_provider.dart';
import '../../data/resource/color_resource_data.dart';
import '../../data/resource/language_resource_data.dart';
import '../../utility/route_utility.dart';

class AppTemplateView extends StatefulWidget {
  final String name;
  final Widget layout;

  const AppTemplateView({
    Key? key,
    required this.name,
    required this.layout,
  }) : super(key: key);

  @override
  State<AppTemplateView> createState() => _AppTemplateViewState();
}

class _AppTemplateViewState extends State<AppTemplateView> with WidgetsBindingObserver {
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
      if (AppProvider.of(context).themeMode == ThemeMode.system) {
        AppProvider.of(context).updateBrightness(WidgetsBinding.instance.window.platformBrightness);
      } else {
        AppProvider.of(context).updateBrightness(Theme.of(context).brightness);
      }
    }

    super.didChangePlatformBrightness();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.name,
      home: widget.layout,
      themeMode: AppProvider.listen(context).themeMode,
      navigatorKey: RouteUtility.navigatorKey,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: ColorResourceData.light.primary,
        colorScheme: ColorScheme.light(
          brightness: Brightness.light,
          primary: ColorResourceData.light.primary,
          onPrimary: ColorResourceData.light.onPrimary,
          primaryContainer: ColorResourceData.light.primaryContainer,
          onPrimaryContainer: ColorResourceData.light.onPrimaryContainer,
          secondary: ColorResourceData.light.secondary,
          onSecondary: ColorResourceData.light.onSecondary,
          secondaryContainer: ColorResourceData.light.secondaryContainer,
          onSecondaryContainer: ColorResourceData.light.onSecondaryContainer,
          error: ColorResourceData.light.error,
          onError: ColorResourceData.light.onError,
          errorContainer: ColorResourceData.light.errorContainer,
          onErrorContainer: ColorResourceData.light.onErrorContainer,
          background: ColorResourceData.light.background,
          onBackground: ColorResourceData.light.onBackground,
          surface: ColorResourceData.light.surface,
          onSurface: ColorResourceData.light.onSurface,
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(ColorResourceData.light.primary),
        ),
        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(ColorResourceData.light.primary),
        ),
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        primaryColor: ColorResourceData.dark.primary,
        colorScheme: ColorScheme.dark(
          brightness: Brightness.dark,
          primary: ColorResourceData.dark.primary,
          onPrimary: ColorResourceData.dark.onPrimary,
          primaryContainer: ColorResourceData.dark.primaryContainer,
          onPrimaryContainer: ColorResourceData.dark.onPrimaryContainer,
          secondary: ColorResourceData.dark.secondary,
          onSecondary: ColorResourceData.dark.onSecondary,
          secondaryContainer: ColorResourceData.dark.secondaryContainer,
          onSecondaryContainer: ColorResourceData.dark.onSecondaryContainer,
          error: ColorResourceData.dark.error,
          onError: ColorResourceData.dark.onError,
          errorContainer: ColorResourceData.dark.errorContainer,
          onErrorContainer: ColorResourceData.dark.onErrorContainer,
          background: ColorResourceData.dark.background,
          onBackground: ColorResourceData.dark.onBackground,
          surface: ColorResourceData.dark.surface,
          onSurface: ColorResourceData.dark.onSurface,
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(ColorResourceData.dark.primary),
        ),
        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(ColorResourceData.dark.primary),
        ),
      ),
      locale: AppProvider.listen(context).locale,
      supportedLocales: LanguageResourceData.supportedLocaleList,
      localizationsDelegates: LanguageResourceData.localizationDelegateList,
    );
  }
}
