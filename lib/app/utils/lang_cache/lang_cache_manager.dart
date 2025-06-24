import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/spot_goods/spot_goods_api.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/lang_cache/core/lang_disk_cache.dart';
import 'package:nt_app_flutter/app/utils/utilities/log_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:path_provider/path_provider.dart';

import '../../cache/app_cache.dart';
import '../../models/contract/res/public_info.dart';
import 'core/lang_memery_cache.dart';

class LangCacheManager {
  static LangCacheManager? _instance;

  static LangCacheManager instance() {
    _instance ??= LangCacheManager._();
    return _instance!;
  }

  LangCacheManager._();

  Future preInit() async {
    checkLangUpdate();
    await _getLangList();
  }

  static List<Locale> supportLocals = const [
    Locale('en', 'US'),
  ];

  List<LangInfo> _langInfoList = [];
  Map<String, LangInfo> _langInfoMap = {};

  List<LangInfo> get langInfoList => _langInfoList;

  Map<String, LangInfo> get langInfoMap => _langInfoMap;

  Future<void> checkLangUpdate() async {
    final res = await SpotGoodsApi.instance().publicInfo();
    if (ObjectUtil.isNotEmpty(res.langList)) {
      /// type 2 为app语言
      List<LangInfo> langInfoList = res.langList!.where((element) {
        return element.type == 2;
      }).toList();
      await setLangInfoList(langInfoList);
    }
  }

  /// 获取语言列表
  setLangInfoList(List<LangInfo> value) async {
    if (_langInfoList.isNotEmpty) {
      bool isUpdate = false;
      List<String> changeKey = [];
      for (var element in value) {
        LangInfo? langInfo = _langInfoMap[element.langKey];
        // 判断是否更新
        if (langInfo != null) {
          if (langInfo.mtime.toNum() < element.mtime.toNum()) {
            _clearCache(langInfo.langKey);
            changeKey.add(element.langKey);
            isUpdate = true;
          }
        } else {
          changeKey.add(element.langKey);
          isUpdate = true;
        }
      }
      _langInfoList = value;
      _langInfoList.sort((a, b) => a.sort.compareTo(b.sort));
      if (isUpdate) {
        _langInfoMap = _langInfoList
            .asMap()
            .map((key, value) => MapEntry(value.langKey, value));
        supportLocals = _langInfoList.map((e) => e.locale).toList();
        await Get.forceAppUpdate();

        /// 预加载缺失的语言包(仅限当前的选中的语言类型，其他的不预加载，在切换的时候会重新加载，因为缓存已经清理)
        String? currentLangKey = ObjectKV.localLang.get((v) => LangInfo.fromJson(v as Map<String, dynamic>))?.langKey;
        if (currentLangKey != null && changeKey.contains(currentLangKey)) {
          await _preLoadCurrentLangkey();
        }
        String langInfoListStr = jsonEncode(_langInfoList);
        StringKV.downLoadLangUrlList.set(langInfoListStr);
      }
    } else {
      _langInfoList = value;
      _langInfoList.sort((a, b) => a.sort.compareTo(b.sort));
      _langInfoMap = _langInfoList
          .asMap()
          .map((key, value) => MapEntry(value.langKey, value));
      supportLocals = _langInfoList.map((e) => e.locale).toList();
      await Get.forceAppUpdate();
      await _preLoadLangKey('en_US', false);
      String langInfoListStr = jsonEncode(_langInfoList);
      StringKV.downLoadLangUrlList.set(langInfoListStr, false);
    }
  }

  Future<Map<String, String>> getCache(String key,
      {bool showLoading = false}) async {
    Map<String, String> cache = LangMemoryCache.instance().cache[key] ?? {};
    if (cache.isNotEmpty) {
      return cache;
    } else {
      final Map<String, String> diskCache =
          await LangDiskCache.instance().get(key);
      if (diskCache.isNotEmpty) {
        LangMemoryCache.instance().set(key, diskCache);
        return diskCache;
      } else {
        try {
          if (showLoading) {
            EasyLoading.show();
          }
          Map<String, Map<String, String>> data =
              await _downLoad(fileName: key);
          if (data.isNotEmpty) {
            Map<String, String> res = data[key]!;
            _setCache(key, res);
            return res;
          } else {
            return {};
          }
        } on Exception catch (e) {
          return {};
        } finally {
          EasyLoading.dismiss();
        }
      }
    }
  }

  void clearCache() {
    LangMemoryCache.instance().clear();
    LangDiskCache.instance().clear();
  }

  /// 获取语言列表
  Future _getLangList() async {
    if (_langInfoList.isNotEmpty) return;

    /// 本地持久化中取出语言列表
    List<LangInfo>? langInfoList = JsonUtil.getObjectList(
        StringKV.downLoadLangUrlList.get(),
        (v) => LangInfo.fromJson(v as Map<String, dynamic>));

    /// 清理脏数据
    langInfoList?.removeWhere((element) => element.type != 2);
    if (langInfoList != null) {
      _langInfoList = langInfoList;
      _langInfoMap = _langInfoList
          .asMap()
          .map((key, value) => MapEntry(value.langKey, value));
      supportLocals = langInfoList.map((e) => e.locale).toList();

      /// 预加载本地数据
      await _preLoadCurrentLangkey();
    }
  }
}

extension LangCacheManagerExt on LangCacheManager {
  /// 预加载本地选中的语言包
  Future<void> _preLoadCurrentLangkey() async {
    LangInfo? langInfo = ObjectKV.localLang.get((v) => LangInfo.fromJson(v as Map<String, dynamic>));
    if (ObjectUtil.isNotEmpty(langInfo?.langKey)) {
      await _preLoadLangKey(langInfo!.langKey);
    }
  }

  /// 预加载语言包
  Future<void> _preLoadLangKey(String langKey, [bool isUpdate = true]) async {
    final value = await getCache(langKey);
    if (value.isNotEmpty && isUpdate) {
      /// 如果有值，更新缓存,没有值不更新
      Map<String, String> targetMap =
          Map.from(AppTranslation.translations[langKey] ?? {});
      value.forEach((k, v) {
        if (v.isNotEmpty) {
          targetMap[k] = v;
        }
      });

      AppTranslation.translations.addAll({langKey: targetMap});
      Get.translations.addAll(AppTranslation.translations);
      await Get.forceAppUpdate();
    }
  }

  void _clearCache(String key) {
    LangMemoryCache.instance().remove(key);
    LangDiskCache.instance().setAll(LangMemoryCache.instance().cache);
  }

  void _setCache(String key, Map<String, String> value) {
    LangMemoryCache.instance().set(key, value);
    LangDiskCache.instance().setAll(LangMemoryCache.instance().cache);
  }

  Future<Map<String, Map<String, String>>> _downLoad(
      {required String fileName}) async {
    /// 查找下载地址
    String url = _langInfoMap[fileName]?.nowFileAddress ?? '';
    if (url.isEmpty) {
      return {};
    }
    // 下载语言包
    try {
      Directory directory = await getTemporaryDirectory();
      String savePath = '${directory.path}/$fileName.json';
      File file = File(savePath);
      Dio dio = Dio();
      await dio.download(url, savePath).timeout(const Duration(seconds: 5));
      file = File(savePath);
      String content = await file.readAsString();

      /// 替换换行符
      content = content.replaceAll(r'\\n', r'\n');
      Map<String, dynamic> data = json.decode(content);
      Map<String, String> targetData = {};
      data.forEach((key, value) {
        targetData[key] = value.toString();
      });
      file.delete();
      return {fileName: targetData};
    } catch (e) {
      String targetFileName = fileName;
      if(fileName == 'zh_TW') {
        targetFileName = 'el_GR';
      } else if(fileName == 'el_GR') {
        targetFileName = 'xl_XL';
      }
      final jsonString = await rootBundle.loadString('assets/locales/$targetFileName.json');
      final Map<String, dynamic> data = json.decode(jsonString);
      final map = {fileName: data.map((key, value) => MapEntry(key, value.toString()))};
      return map;
    }
  }
}
