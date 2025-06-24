// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/cache/app_cache.dart';
import 'package:nt_app_flutter/app/models/home/quick_entry_info.dart';
import 'package:nt_app_flutter/app/modules/my/quick_entry/controllers/quick_entry_controller.dart';
import 'package:nt_app_flutter/app/utils/bus/event_bus.dart';
import 'package:nt_app_flutter/app/utils/bus/event_type.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../utils/utilities/platform_util.dart';

class FavoriteQuickEntryController extends GetxController {
  static FavoriteQuickEntryController get to => Get.find();

  RxList<QuickEntryInfo> quickEntryInfos = RxList<QuickEntryInfo>();
  int beforeIndex = -1;
  int afterIndex = -1;

  /// 是否编辑并且保存
  bool? editHasSave;

  @override
  void onInit() {
    super.onInit();
    loadDb();
    if (quickEntryInfos.isEmpty) {
      _loadJson();
    }
    addNotification();
  }

  loadDb() {
    List<String>? list = ListKV.quickEntry.get<String>();
    if (list != null) {
      quickEntryInfos
          .assignAll(list.map((e) => QuickEntryInfo.fromString(e)).toList());
      int index = quickEntryInfos.indexWhere((e) => e.title == 'trade3');

      /// 将历史保存的现货交易替换为卡券
      if (index != -1) {
        quickEntryInfos.removeAt(index);
      }
      if (MyPlatFormUtil.isIOS()) {
        /// iOS 暂时去掉标准合约的入口
        quickEntryInfos.removeWhere((element) =>
            element.title == 'other48' || element.title == 'trade4');
      }
      quickEntryInfos.refresh();
    }
  }

  _loadJson() async {
    final res =
        await rootBundle.loadString('assets/json/quick_entry/main_quick.json');
    Map<String, dynamic> map = json.decode(res);
    final quickEntryList = List<QuickEntryInfo>.from(map['quick_entry']
        .map((x) => QuickEntryInfo.fromMap(x as Map<String, dynamic>)));
    if (MyPlatFormUtil.isIOS()) {
      /// iOS 暂时去掉标准合约的入口
      quickEntryList.removeWhere(
          (element) => element.title == 'other48' || element.title == 'trade4');
    }
    quickEntryInfos.assignAll(quickEntryList);
  }

  void addQuickEntry(QuickEntryInfo quickEntryInfo) {
    if (quickEntryInfos.length >= 9) {
      UIUtil.showToast(LocaleKeys.other45.tr.replaceAll('7', '9'));
      return;
    }
    if (quickEntryInfos.contains(quickEntryInfo)) {
      return;
    }
    quickEntryInfos.add(quickEntryInfo);
    editHasSave = false;
    QuickEntryController.to.update();
  }

  void removeQuickEntry(QuickEntryInfo quickEntryInfo) {
    quickEntryInfos.remove(quickEntryInfo);
    editHasSave = false;
    QuickEntryController.to.update();
  }

  void save() {
    if (beforeIndex >= 0 && afterIndex >= 0) {
      QuickEntryInfo before = quickEntryInfos[beforeIndex];
      QuickEntryInfo after = quickEntryInfos[afterIndex];
      quickEntryInfos[beforeIndex] = after;
      quickEntryInfos[afterIndex] = before;
      quickEntryInfos.refresh();
    }
    if (quickEntryInfos.isEmpty) {
      ListKV.quickEntry.clear();
      _loadJson();
    } else {
      List<String> list =
          quickEntryInfos.map((e) => json.encode(e.toMap())).toList();
      ListKV.quickEntry.set(list);
    }
    editHasSave = true;
  }

  Set quickNameSet = {};
  addNotification() {
    Bus.getInstance().on(EventType.quicEntry, (data) {
      quickNameSet.add(data);
      quickEntryInfos.removeWhere((element) => element.title == data);
      FavoriteQuickEntryController.to.save();
    });
  }
}
