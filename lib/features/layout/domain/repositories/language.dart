import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../../../core/helpers/storage_helper.dart';

class LanguageRepository {
  static String initLanguage() {
    final String defaultLocale = Platform.localeName;
    final String? lang = StorageHelper.getData(key: 'lang');
    final String appLang = lang ?? defaultLocale.split('_')[0];
    debugPrint('appLang $appLang');
    return appLang;
  }

  static void setLangData(lang) {
    debugPrint("set language data $lang");
    StorageHelper.saveData(key: 'lang', value: lang);
  }
}
