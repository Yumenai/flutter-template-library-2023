import 'package:flutter_gen/gen_l10n/app_localization.dart';

class LanguageResourceData {
  static const localizationDelegateList = AppLocalizations.localizationsDelegates;

  static const supportedLocaleList = AppLocalizations.supportedLocales;

  /// Language Code: Language Native Name
  static const supportedInformationList = {
    'en': 'English',
    'zh': '中文',
  };

  const LanguageResourceData._();
}
