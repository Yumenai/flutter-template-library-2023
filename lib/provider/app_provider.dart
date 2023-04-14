import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';

import '../data/configuration_data.dart';
import '../data/resource/color_resource_data.dart';
import '../data/resource/image_resource_data.dart';
import '../data/variable/environment_variable_data.dart';
import '../data/resource/language_resource_data.dart';
import '../directory/repository_directory.dart';

class AppProvider extends ChangeNotifier {
  static Future<AppProvider> initialise() async {
    final ColorResourceData colorResource;
    final ImageResourceData imageResource;

    switch(RepositoryDirectory.app?.themeMode ?? ConfigurationData.defaultThemeMode) {
      case ThemeMode.system:
        if (WidgetsBinding.instance.window.platformBrightness == Brightness.light) {
          colorResource = ColorResourceData.light;
          imageResource = ImageResourceData.light;
        } else {
          colorResource = ColorResourceData.dark;
          imageResource = ImageResourceData.dark;
        }
        break;
      case ThemeMode.light:
        colorResource = ColorResourceData.light;
        imageResource = ImageResourceData.light;
        break;
      case ThemeMode.dark:
        colorResource = ColorResourceData.dark;
        imageResource = ImageResourceData.dark;
        break;
    }

    return AppProvider._(
      colorResource,
      imageResource,
      await ConfigurationData.defaultLocalizationDelegate.load(RepositoryDirectory.app?.locale ?? ConfigurationData.defaultLocale),
    );
  }

  static AppProvider of(final BuildContext context) {
    return Provider.of<AppProvider>(
      context,
      listen: false,
    );
  }

  static AppProvider listen(final BuildContext context) {
    return Provider.of<AppProvider>(context);
  }

  Locale get locale => RepositoryDirectory.app?.locale ?? ConfigurationData.defaultLocale;

  ThemeMode get themeMode => RepositoryDirectory.app?.themeMode ?? ConfigurationData.defaultThemeMode;

  ColorResourceData _color;
  ColorResourceData get color => _color;

  ImageResourceData _image;
  ImageResourceData get image => _image;

  AppLocalizations? _text;
  AppLocalizations? get text => _text;

  AppProvider._(this._color, this._image, this._text,);

  Future<void> updateTheme(final ThemeMode themeMode) async {
    /// If the locale is the same, skip this update
    if (themeMode == RepositoryDirectory.app?.themeMode) return;

    RepositoryDirectory.app?.themeMode = themeMode;

    switch(themeMode) {
      case ThemeMode.system:
        updateBrightness(WidgetsBinding.instance.window.platformBrightness);
        break;
      case ThemeMode.light:
        updateBrightness(Brightness.light);
        break;
      case ThemeMode.dark:
        updateBrightness(Brightness.dark);
        break;
    }
  }

  Future<void> updateLanguage(final String languageCode) async {
    /// If the locale is the same, skip this update
    if (languageCode == RepositoryDirectory.app?.locale.languageCode) return;

    final locale = LanguageResourceData.supportedLocaleList.firstWhere((locale) {
      return locale.languageCode == languageCode;
    }, orElse: () {
      return ConfigurationData.defaultLocale;
    });

    RepositoryDirectory.app?.locale = locale;

    final textResource = await LanguageResourceData.localizationDelegateList.first.load(locale);

    if (textResource is AppLocalizations) {
      _text = textResource;
    }

    notifyListeners();
  }

  Future<void> updateEnvironment(final EnvironmentVariableData environment) async {
    if (environment == RepositoryDirectory.app?.environmentVariable) return;

    RepositoryDirectory.app?.environmentVariable = environment;
  }

  void updateBrightness(final Brightness brightness) {
    if (brightness == Brightness.dark) {
      _color = ColorResourceData.dark;
      _image = ImageResourceData.dark;
    } else {
      _color = ColorResourceData.light;
      _image = ImageResourceData.light;
    }

    notifyListeners();
  }
}
