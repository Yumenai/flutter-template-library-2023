import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class LanguageResourceData {
  static List<LocalizationsDelegate> localizationDelegateList = AppLocalizations.localizationsDelegates;

  static List<Locale> supportedLocaleList = AppLocalizations.supportedLocales;

  /// Language Code: Language Native Name
  static Map<String, String> supportedInformationList = {
    'en': "English",
    'zh': '中文',
  };

  const LanguageResourceData._();
}