import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:provider/provider.dart';

import '../data/configuration_data.dart';
import '../data/variable/color_variable_data.dart';
import '../data/variable/environment_variable_data.dart';
import '../data/variable/image_variable_data.dart';
import '../module/app/app_module.dart';
import '../module/authentication/authentication_module.dart';
import '../module/scanner/scanner_module.dart';
import '../module/user/user_module.dart';

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

  final _appModule = AppModule();
  final _authenticationModule = AuthenticationModule();
  final _userModule = UserModule();
  final _scannerModule = ScannerModule();

  Locale get locale => _userModule.repository.locale ?? ConfigurationData.defaultLocale;
  ThemeMode get themeMode => _userModule.repository.themeMode ?? ConfigurationData.defaultThemeMode;

  ColorVariableData? _color;
  ColorVariableData get color => _color ?? ColorVariableData.light;

  ImageVariableData? _image;
  ImageVariableData get image => _image ?? ImageVariableData.light;

  AppLocalizations? _text;
  AppLocalizations? get text => _text;

  String get accessToken => _userModule.repository.sessionAccessToken;

  EnvironmentVariableData? _environment;
  EnvironmentVariableData get environment => _environment ?? ConfigurationData.defaultEnvironment;
  set environment(environment) {
    _environment = environment;
    _appModule.repository.setEnvironment(environment);
  }

  Future<AppProvider> setup() async {
    await _appModule.initialise(
      provider: (context) => of(context)._appModule,
      viewSignIn: _authenticationModule.directoryRoute.login.navigate,
      viewSignUp: _authenticationModule.directoryRoute.registration.navigate,
      viewProfileSettings: _userModule.directoryRoute.profile.navigate,
      viewPasswordSettings: _userModule.directoryRoute.password.navigate,
      viewThemeSettings: _userModule.directoryRoute.theme.navigate,
      viewLanguageSettings: _userModule.directoryRoute.language.navigate,
      viewAccountDeletion: _userModule.directoryRoute.deletion.navigate,
      getCodeScanner: _scannerModule.directoryRoute.code.navigate,
      onSetup: _userModule.startup,
      onSignOut: () async {
        await _appModule.clear();
        await _authenticationModule.clear();
        await _userModule.clear();
      },
    );

    await _authenticationModule.initialise(
      provider: (context) => of(context)._authenticationModule,
      viewSplash: _appModule.directoryRoute.splash.navigate,
    );

    await _userModule.initialise(
      provider: (context) => of(context)._userModule,
      viewSplash: _appModule.directoryRoute.splash.navigate,
      getSessionRefreshToken: _authenticationModule.repository.getSessionRefreshToken,
      onDeleteAccount: () async {
        await _appModule.clear();
        await _authenticationModule.clear();
        await _userModule.clear();
      },
    );

    await _scannerModule.initialise(
      provider: (context) => of(context)._scannerModule,
    );

    await _updateTheme(themeMode);
    await _updateLanguage(locale.languageCode);

    return this;
  }

  Widget startupRoute() => _appModule.directoryRoute.splash.build();

  Future<void> updateTheme(final ThemeMode themeMode) async {
    /// If the locale is the same, skip this update
    if (themeMode == _userModule.repository.themeMode) return;

    await _updateTheme(themeMode);
    notifyListeners();
  }

  Future<void> updateLanguage(final String languageCode) async {
    /// If the locale is the same, skip this update
    if (languageCode == _userModule.repository.locale?.languageCode) return;

    await _updateLanguage(languageCode);
    notifyListeners();
  }

  void updateBrightness(final Brightness brightness) {
    _updateBrightness(brightness);
    notifyListeners();
  }

  Future<void> _updateTheme(final ThemeMode themeMode) async {
    _userModule.repository.themeMode = themeMode;

    switch(themeMode) {
      case ThemeMode.system:
        _updateBrightness(WidgetsBinding.instance.window.platformBrightness);
        break;
      case ThemeMode.light:
        _updateBrightness(Brightness.light);
        break;
      case ThemeMode.dark:
        _updateBrightness(Brightness.dark);
        break;
    }
  }

  Future<void> _updateLanguage(final String languageCode) async {
    Locale replacementLocale = ConfigurationData.defaultLocale;

    for (final locale in ConfigurationData.supportedLocaleList) {
      if (locale.languageCode == languageCode) {
        replacementLocale = locale;
      }
    }

    _userModule.repository.locale = replacementLocale;

    final textResource = await ConfigurationData.localizationDelegateList.first.load(replacementLocale);

    if (textResource is AppLocalizations) {
      _text = textResource;
    }
  }

  void _updateBrightness(final Brightness brightness) {
    if (brightness == Brightness.dark) {
      _color = ColorVariableData.dark;
      _image = ImageVariableData.dark;
    } else {
      _color = ColorVariableData.light;
      _image = ImageVariableData.light;
    }
  }
}
