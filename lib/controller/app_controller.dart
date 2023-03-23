import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';

import '../data/configuration_data.dart';
import '../data/resource/color_resource_data.dart';
import '../data/resource/image_resource_data.dart';
import '../data/resource/language_resource_data.dart';
import '../service/repository_service.dart';

class AppController extends ChangeNotifier {
  static Future<AppController> initialise() async {
    final languageCode = RepositoryService.key.appLanguageCode;

    final locale = LanguageResourceData.supportedLocaleList.firstWhere((locale) {
      return locale.languageCode == languageCode;
    }, orElse: () {
      return ConfigurationData.defaultLocale;
    });

    final themeMode = RepositoryService.key.appThemeMode ?? ConfigurationData.defaultThemeMode;
    final ColorResourceData colorResourceData;
    final ImageResourceData imageResourceData;

    switch(themeMode) {
      case ThemeMode.system:
        if (WidgetsBinding.instance.window.platformBrightness == Brightness.light) {
          colorResourceData = const ColorResourceData.light();
          imageResourceData = const ImageResourceData.light();
        } else {
          colorResourceData = const ColorResourceData.dark();
          imageResourceData = const ImageResourceData.dark();
        }
        break;
      case ThemeMode.light:
        colorResourceData = const ColorResourceData.light();
        imageResourceData = const ImageResourceData.light();
        break;
      case ThemeMode.dark:
        colorResourceData = const ColorResourceData.dark();
        imageResourceData = const ImageResourceData.dark();
        break;
    }

    return AppController._(
      colorResourceData,
      imageResourceData,
      await ConfigurationData.defaultLocalizationDelegate.load(locale),
    );
  }

  static AppController of(final BuildContext context) {
    return Provider.of<AppController>(
      context,
      listen: false,
    );
  }

  static AppController listen(final BuildContext context) {
    return Provider.of<AppController>(context);
  }

  ColorResourceData _color;
  ColorResourceData get color => _color;

  ImageResourceData _image;
  ImageResourceData get image => _image;

  AppLocalizations? _text;
  AppLocalizations? get text => _text;

  AppController._(this._color, this._image, this._text,);

  Locale get locale {
    final languageCode = RepositoryService.key.appLanguageCode;

    return LanguageResourceData.supportedLocaleList.firstWhere((locale) {
      return locale.languageCode == languageCode;
    }, orElse: () {
      return ConfigurationData.defaultLocale;
    });
  }

  ThemeMode get themeMode {
    return RepositoryService.key.appThemeMode ?? ConfigurationData.defaultThemeMode;
  }

  void updateTheme(final ThemeMode themeMode) async {
    /// If the locale is the same, skip this update
    if (themeMode == RepositoryService.key.appThemeMode) return;

    await RepositoryService.key.setAppThemeMode(themeMode);

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

  void updateLanguage(final String languageCode) async {
    /// If the locale is the same, skip this update
    if (languageCode == RepositoryService.key.appLanguageCode) return;

    final locale = LanguageResourceData.supportedLocaleList.firstWhere((locale) {
      return locale.languageCode == languageCode;
    }, orElse: () {
      return ConfigurationData.defaultLocale;
    });

    await RepositoryService.key.setAppLanguageCode(languageCode);

    final textResource = await LanguageResourceData.localizationDelegateList.first.load(locale);

    if (textResource is AppLocalizations) {
      _text = textResource;
    }

    notifyListeners();
  }

  void updateBrightness(final Brightness brightness) {
    if (brightness == Brightness.dark) {
      _color = const ColorResourceData.dark();
      _image = const ImageResourceData.dark();
    } else {
      _color = const ColorResourceData.light();
      _image = const ImageResourceData.light();
    }

    notifyListeners();
  }
}
