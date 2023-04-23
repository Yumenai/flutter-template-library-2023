import 'package:flutter/material.dart';

import '../../data/configuration_data.dart';
import '../../provider/app_provider.dart';
import '../../data/variable/color_variable_data.dart';
import '../../service/route_service.dart';

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
      navigatorKey: RouteService.navigatorKey,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        primaryColor: ColorVariableData.light.primary,
        colorScheme: ColorScheme.light(
          brightness: Brightness.light,
          primary: ColorVariableData.light.primary,
          onPrimary: ColorVariableData.light.onPrimary,
          primaryContainer: ColorVariableData.light.primaryContainer,
          onPrimaryContainer: ColorVariableData.light.onPrimaryContainer,
          secondary: ColorVariableData.light.secondary,
          onSecondary: ColorVariableData.light.onSecondary,
          secondaryContainer: ColorVariableData.light.secondaryContainer,
          onSecondaryContainer: ColorVariableData.light.onSecondaryContainer,
          error: ColorVariableData.light.error,
          onError: ColorVariableData.light.onError,
          errorContainer: ColorVariableData.light.errorContainer,
          onErrorContainer: ColorVariableData.light.onErrorContainer,
          background: ColorVariableData.light.background,
          onBackground: ColorVariableData.light.onBackground,
          surface: ColorVariableData.light.surface,
          onSurface: ColorVariableData.light.onSurface,
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(ColorVariableData.light.primary),
        ),
        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(ColorVariableData.light.primary),
        ),
      ),
      darkTheme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        primaryColor: ColorVariableData.dark.primary,
        colorScheme: ColorScheme.dark(
          brightness: Brightness.dark,
          primary: ColorVariableData.dark.primary,
          onPrimary: ColorVariableData.dark.onPrimary,
          primaryContainer: ColorVariableData.dark.primaryContainer,
          onPrimaryContainer: ColorVariableData.dark.onPrimaryContainer,
          secondary: ColorVariableData.dark.secondary,
          onSecondary: ColorVariableData.dark.onSecondary,
          secondaryContainer: ColorVariableData.dark.secondaryContainer,
          onSecondaryContainer: ColorVariableData.dark.onSecondaryContainer,
          error: ColorVariableData.dark.error,
          onError: ColorVariableData.dark.onError,
          errorContainer: ColorVariableData.dark.errorContainer,
          onErrorContainer: ColorVariableData.dark.onErrorContainer,
          background: ColorVariableData.dark.background,
          onBackground: ColorVariableData.dark.onBackground,
          surface: ColorVariableData.dark.surface,
          onSurface: ColorVariableData.dark.onSurface,
        ),
        radioTheme: RadioThemeData(
          fillColor: MaterialStateProperty.all(ColorVariableData.dark.primary),
        ),
        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(ColorVariableData.dark.primary),
        ),
      ),
      locale: AppProvider.listen(context).locale,
      supportedLocales: ConfigurationData.supportedLocaleList,
      localizationsDelegates: ConfigurationData.localizationDelegateList,
    );
  }
}
