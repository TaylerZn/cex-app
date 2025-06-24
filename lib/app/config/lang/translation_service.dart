import 'dart:ui';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';

import '../../../generated/locales.g.dart';
import '../../cache/app_cache.dart';

class TranslationService extends Translations {
  static const fallbackLocale = Locale('en', 'US');

  static Locale getInitLocale() {
    LangInfo? langInfo = ObjectKV.localLang.get((v) => LangInfo.fromJson(v as Map<String, dynamic>));
    if(langInfo == null) {
      return fallbackLocale;
    } else {
      return langInfo.locale;
    }
  }

  @override
  Map<String, Map<String, String>> get keys => AppTranslation.translations;
}
