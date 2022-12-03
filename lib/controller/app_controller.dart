import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';

import '../data/resource/color_resource_data.dart';
import '../data/resource/image_resource_data.dart';
import '../data/resource/language_resource_data.dart';

class AppController extends ChangeNotifier {
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

  AppController()
      : _themeMode = ThemeMode.light,
        _locale = LanguageResourceData.supportedLocaleList.first,
        _color = const ColorResourceData.light(),
        _image = const ImageResourceData.light();

  AppLocalizations? text(final BuildContext context) => AppLocalizations.of(context);

  void updateTheme(final ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  void updateLanguage(final String languageCode) {
    for (final locale in LanguageResourceData.supportedLocaleList) {
      if (locale.languageCode == languageCode) {
        _locale = locale;
        notifyListeners();
        break;
      }
    }
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
