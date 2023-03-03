import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';

import '../data/app_data.dart';
import '../data/resource/color_resource_data.dart';
import '../data/resource/image_resource_data.dart';
import '../data/resource/language_resource_data.dart';
import '../data/variable/environment_variable_data.dart';
import '../service/repository_service.dart';

class AppController extends ChangeNotifier {
  static Future<AppController> initialise() async {

    final languageCode = await RepositoryService.storage.key.appLanguageCode;

    final locale = LanguageResourceData.supportedLocaleList.firstWhere((locale) {
      return locale.languageCode == languageCode;
    }, orElse: () {
      return AppData.defaultLocale;
    });

    final themeMode = await RepositoryService.storage.key.appThemeMode ?? AppData.defaultThemeMode;
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
      themeMode,
      locale,
      colorResourceData,
      imageResourceData,
      await AppData.defaultLocalizationDelegate.load(locale),
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

  ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  Locale _locale;
  Locale? get locale => _locale;

  ColorResourceData _color;
  ColorResourceData get color => _color;

  ImageResourceData _image;
  ImageResourceData get image => _image;

  AppLocalizations? _text;
  AppLocalizations? get text => _text;

  EnvironmentVariableData _environment = EnvironmentVariableData.development;
  EnvironmentVariableData get environment => _environment;

  String get hostAddress {
    switch(_environment) {
      case EnvironmentVariableData.production:
        return AppData.hostAddressProduction;
      case EnvironmentVariableData.userAcceptanceTest:
        return AppData.hostAddressUserAcceptanceTest;
      case EnvironmentVariableData.systemIntegrationTest:
        return AppData.hostAddressSystemIntegrationTest;
      case EnvironmentVariableData.development:
        return AppData.hostAddressDevelopment;
    }
  }

  AppController._(this._themeMode, this._locale, this._color, this._image, this._text,);

  void updateTheme(final ThemeMode themeMode) async {
    /// If the locale is the same, skip this update
    if (themeMode == _themeMode) return;

    await RepositoryService.storage.key.setAppThemeMode(themeMode);
    _themeMode = themeMode;

    if (_themeMode == ThemeMode.system) {
      updateBrightness(WidgetsBinding.instance.window.platformBrightness);
    } else if (_themeMode == ThemeMode.light) {
      updateBrightness(Brightness.light);
    } else if (_themeMode == ThemeMode.dark) {
      updateBrightness(Brightness.dark);
    }
  }

  void updateEnvironment({
    final bool toProduction = false,
    final bool toUserAcceptanceTest = false,
    final bool toSystemIntegrationTest = false,
    final bool toDevelopment = false,
  }) async {
    if (toProduction) {
      _environment = EnvironmentVariableData.production;
    } else if (toUserAcceptanceTest) {
      _environment = EnvironmentVariableData.userAcceptanceTest;
    } else if (toSystemIntegrationTest) {
      _environment = EnvironmentVariableData.systemIntegrationTest;
    } else if (toDevelopment) {
      _environment = EnvironmentVariableData.development;
    } else {
      return;
    }

    await RepositoryService.storage.key.setEnvironmentData(_environment);
  }

  void updateLanguage(final String languageCode) async {
    final locale = LanguageResourceData.supportedLocaleList.firstWhere((locale) {
      return locale.languageCode == languageCode;
    }, orElse: () {
      return AppData.defaultLocale;
    });

    /// If the locale is the same, skip this update
    if (locale == _locale) return;

    await RepositoryService.storage.key.setAppLanguageCode(languageCode);
    _locale = locale;

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
