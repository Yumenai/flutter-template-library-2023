import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';

import '../data/configuration_data.dart';
import '../data/variable/color_variable_data.dart';
import '../data/variable/environment_variable_data.dart';
import '../data/variable/image_variable_data.dart';
import '../module/app/app_master.dart';
import '../module/authenticate/authenticate_master.dart';
import '../module/user/user_master.dart';

class AppProvider extends ChangeNotifier {
  static AppProvider of(final BuildContext context) {
    return Provider.of<AppProvider>(
      context,
      listen: false,
    );
  }

  static AppProvider listen(final BuildContext context) {
    return Provider.of<AppProvider>(context);
  }

  final _appModule = AppMaster();
  final _authenticateModule = AuthenticateMaster();
  final _userModule = UserMaster();

  Locale? _locale;
  Locale get locale => _locale ?? ConfigurationData.defaultLocale;

  ThemeMode? _themeMode;
  ThemeMode get themeMode => _themeMode ?? ConfigurationData.defaultThemeMode;

  ColorVariableData? _color;
  ColorVariableData get color => _color ?? ColorVariableData.light;

  ImageVariableData? _image;
  ImageVariableData get image => _image ?? ImageVariableData.light;

  AppLocalizations? _text;
  AppLocalizations? get text => _text;

  String _accessToken = '';
  String get accessToken => _accessToken;
  set accessToken(token) => _accessToken = token;

  EnvironmentVariableData? _environment;
  EnvironmentVariableData get environment => _environment ?? ConfigurationData.defaultEnvironment;
  set environment(environment) {
    _environment = environment;
    _appModule.repository.setEnvironment(environment);
  }

  Future<AppProvider> setup() async {
    _appModule.initialise(
      provider: (context) => _appModule,
      viewSignIn: () => _authenticateModule.directoryRoute?.navigator.user(),
      viewSignUp: () => _userModule.directoryRoute?.navigator.registration(),
      viewProfileSettings: () {},
      viewPasswordSettings: () => _userModule.directoryRoute?.navigator.password(),
      viewThemeSettings: () => _userModule.directoryRoute?.navigator.theme(),
      viewLanguageSettings: () => _userModule.directoryRoute?.navigator.language(),
      viewAccountDeletion: () {},
      getSessionRefreshToken: _authenticateModule.repository.getSessionRefreshToken,
      onSignOut: () async {
        await _authenticateModule.clear();
        await _userModule.clear();
      },
    );

    _authenticateModule.initialise(
      provider: (context) => _authenticateModule,
      viewSplash: () => _appModule.directoryRoute?.navigator.splash(),
    );

    _userModule.initialise(
      provider: (context) => _userModule,
      viewSplash: () => _appModule.directoryRoute?.navigator.splash(),
    );

    await updateTheme(await _userModule.repository.getThemeMode() ?? ConfigurationData.defaultThemeMode, false);
    await updateLanguage((await _userModule.repository.getLocale() ?? ConfigurationData.defaultLocale).languageCode, false);

    return this;
  }

  Widget? setupScreen() => _appModule.directoryRoute?.screen.splash;

  Future<void> updateTheme(final ThemeMode themeMode, [
    final bool notifyChange = true,
  ]) async {
    /// If the locale is the same, skip this update
    if (themeMode == _themeMode) return;

    _themeMode = themeMode;
    await _userModule.repository.setThemeMode(themeMode);

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

  Future<void> updateLanguage(final String languageCode, [
    final bool notifyChange = true,
  ]) async {
    /// If the locale is the same, skip this update
    if (languageCode == _locale?.languageCode) return;

    final locale = ConfigurationData.supportedLocaleList.firstWhere((locale) {
      return locale.languageCode == languageCode;
    }, orElse: () {
      return ConfigurationData.defaultLocale;
    });

    _locale = locale;
    await _userModule.repository.setLocale(locale);

    final textResource = await ConfigurationData.localizationDelegateList.first.load(locale);

    if (textResource is AppLocalizations) {
      _text = textResource;
    }

    if (notifyChange) {
      notifyListeners();
    }
  }

  void updateBrightness(final Brightness brightness, [
    final bool notifyChange = true,
  ]) {
    if (brightness == Brightness.dark) {
      _color = ColorVariableData.dark;
      _image = ImageVariableData.dark;
    } else {
      _color = ColorVariableData.light;
      _image = ImageVariableData.light;
    }

    if (notifyChange) {
      notifyListeners(); 
    }
  }
}
