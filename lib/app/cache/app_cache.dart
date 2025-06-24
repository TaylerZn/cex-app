import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';

const cacheName = "com.nt.app.cache";

/// 初始化
Future<bool> dbPreInit() async {
  return GetStorage.init(cacheName);
}

final appStorage = GetStorage(cacheName);

Future<void> dbClear() async {
  return appStorage.erase();
}

///////////////////////////////////////////////////////////////
////////////////          保存字符串      //////////////////
///////////////////////////////////////////////////////////////
enum StringKV {
  /// 抓包代理
  httpLocalhost,

  /// 区号
  areaCode,

  /// 语言列表
  downLoadLangUrlList,

  /// 语言包本地缓存
  langMap,
}

extension StringKVX on StringKV {
  String? get() {
    return appStorage.read(name);
  }

  set(String? value, [bool save = true]) {
    if (value != null && value.isNotEmpty) {
      if (save) {
        appStorage.write(name, value);
      } else {
        appStorage.writeInMemory(name, value);
      }
    } else {
      clear();
    }
  }

  clear() {
    appStorage.remove(name);
  }
}

///////////////////////////////////////////////////////////////
////////////////          保存Object      //////////////////
///////////////////////////////////////////////////////////////
enum ObjectKV {
  /// 公共信息
  public,

  /// User用户信息
  user,

  /// User资产信息
  assets,

  /// 地址集
  links,

  ///icon
  icons,

  ///推荐
  recommend,

  ///新手引导
  guide,
  /// 本地语言
  localLang,
}

extension ObjectKVX on ObjectKV {
  T? get<T>(T Function(Map v) f, {T? defValue}) {
    String? data = appStorage.read(name);
    var map = (data == null || data.isEmpty) ? null : json.decode(data);
    return map == null ? defValue : f(map);
  }

  set(Object? value, [bool save = true]) {
    if (value != null) {
      if (save) {
        appStorage.write(name, json.encode(value));
      } else {
        appStorage.writeInMemory(name, json.encode(value));
      }
    } else {
      clear();
    }
  }

  clear() {
    appStorage.remove(name);
  }
}

///////////////////////////////////////////////////////////////
////////////////          保存整形      //////////////////
///////////////////////////////////////////////////////////////
enum IntKV { test }

extension IntKVX on IntKV {
  int? get() {
    return appStorage.read(name);
  }

  set(int value) {
    appStorage.writeInMemory(name, value);
  }

  clear() {
    appStorage.remove(name);
  }
}

///////////////////////////////////////////////////////////////
////////////////          保存bool类型      //////////////////
///////////////////////////////////////////////////////////////
enum BoolKV {
  /// 主题
  darkTheme,
  hasShowAddSpeedTips,
  isFirstInstall,
  myFollowIsText,
  isSetQuery,
}

extension BoolKVX on BoolKV {
  bool? get() {
    return appStorage.read(name);
  }

  set(bool value) {
    appStorage.writeInMemory(name, value);
  }

  clear() {
    appStorage.remove(name);
  }
}

///////////////////////////////////////////////////////////////
////////////////          保存List类型数据      //////////////////
///////////////////////////////////////////////////////////////
enum ListKV {
  /// 大搜索记录
  mainSearchHistory,

  /// 行情搜索
  marketSearchHistory,

  /// 快捷入口
  quickEntry
}

extension ListKVX on ListKV {
  List<T>? get<T>() {
    String? data = appStorage.read(name);
    if (data != null && data.isNotEmpty) {
      List<dynamic> list = json.decode(data);
      return list.map<T>((e) => e as T).toList();
    } else {
      return null;
    }
  }

  add<T>(T item,
      {int? maxLength,
      bool checkExisting = false,
      bool bringOldToFront = false,
      bool isInsert0 = false}) {
    List<T>? existingList = get<T>();
    List<T> updatedList = existingList ?? [];

    // 如果 maxLength 参数不为空，并且列表长度超过了 maxLength，则添加新元素前先删除旧元素
    if (maxLength != null && updatedList.length >= maxLength) {
      updatedList.removeAt(0); // 移除最旧的元素
    }

    // 如果 checkExisting 参数为 true，并且列表中已经存在相同的元素，则根据 bringOldToFront 参数决定是否将旧元素提到最前边
    if (checkExisting && existingList != null && existingList.contains(item)) {
      updatedList.remove(item); // 先移除旧元素
      if (bringOldToFront) {
        updatedList.insert(0, item); // 再将旧元素添加到列表最前边
        set(updatedList);
        return;
      } else {
        return;
      }
    }

    if (isInsert0) {
      updatedList.insert(0, item);
    } else {
      updatedList.add(item);
    }

    set(updatedList);
  }

  set(List value, {bool save = true}) {
    if (save) {
      appStorage.write(name, json.encode(value));
    } else {
      appStorage.writeInMemory(name, json.encode(value));
    }
  }

  clear() {
    appStorage.remove(name);
  }
}

enum MarketKV { favoritesContract, favoritesSpot }

extension MarketKVX on MarketKV {
  List? get() {
    return appStorage.read(getKey);
  }

  set(List value, [bool save = true]) {
    if (save) {
      appStorage.write(getKey, value);
    } else {
      appStorage.writeInMemory(getKey, value);
    }
  }

  clear() {
    appStorage.remove(getKey);
  }

  String get getKey => "$name${UserGetx.to.user?.info?.id ?? '_'}";
}
