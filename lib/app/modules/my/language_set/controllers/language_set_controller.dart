import 'dart:async';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/global/dataStore/spot_data_store_controller.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/lang_cache/lang_cache_manager.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../cache/app_cache.dart';
import '../../../../models/contract/res/public_info.dart';

class LanguageSetController extends GetxController {
  static LanguageSetController to = Get.find();

  final currentLang = LangInfo.defaultLangInfo.obs;

  RxList<LangInfo> langInfoList = RxList();

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> checkLangInfoIfIsEmpty() async {
    try {
      if (LangCacheManager.instance().langInfoList.isEmpty) {
        await LangCacheManager.instance().checkLangUpdate();
      }
      getLangList(true);
    } on Exception catch (e) {
      UIUtil.showError(LocaleKeys.public63.tr);
    }
  }

  getLangList([bool showLoading = false]) async {
    langInfoList.assignAll(LangCacheManager.instance().langInfoList);
    LangInfo langInfo = ObjectKV.localLang.get((v) => LangInfo.fromJson(v as Map<String,dynamic>)) ??
        LangInfo.defaultLangInfo;
    currentLang.value = langInfo;
  }

  Future changeLange(LangInfo locale,[bool showLoading = false]) async {
    try {
      currentLang.value = locale;
      ObjectKV.localLang.set(locale.toJson());
      // StringKV.currentSelectedLangKey.set(locale.langKey);
      // if (!AppTranslation.translations.containsKey(locale.langKey)) {
      //   Map<String, String> langMap = await LangCacheManager.instance()
      //       .getCache(locale.langKey, showLoading: showLoading);
      //   if (langMap.isNotEmpty) {
      //     AppTranslation.translations.addAll({locale.langKey: langMap});
      //     Get.translations.addAll(AppTranslation.translations);
      //     Get.forceAppUpdate();
      //   }
      // }
      Map<String,String> langMap = await LangCacheManager.instance().getCache(locale.langKey, showLoading: showLoading);
      bool hasInject = AppTranslation.translations.containsKey(locale.langKey);
      AppTranslation.translations.addAll({locale.langKey: langMap});
      Get.translations.addAll(AppTranslation.translations);
      if(!hasInject){
        Get.forceAppUpdate();
      }
      Get.updateLocale(locale.locale);
      Bus.getInstance().emit(EventType.changeLang, null);
    } on Exception catch (e) {
      Get.log('error: $e');
    }
  }
}
