import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/models/home/quick_entry_info.dart';
import 'package:nt_app_flutter/app/modules/my/quick_entry/controllers/favorite_quick_entry_controller.dart';
import 'package:nt_app_flutter/app/utils/utilities/platform_util.dart';

class QuickEntryController extends GetxController {
  static QuickEntryController get to => Get.find();

  bool isEditing = false;
  List<QuickEntryList> quickEntryList = [];

  _loadJson() async {
    final res =
        await rootBundle.loadString('assets/json/quick_entry/quick_entry.json');
    Map<String, dynamic> map = json.decode(res);
    quickEntryList = List<QuickEntryList>.from(map['quick_entry']
        .map((x) => QuickEntryList.fromJson(x as Map<String, dynamic>)));
    if (MyPlatFormUtil.isIOS()) {
      /// iOS 暂时去掉标准合约的入口
      final titles = [
        'other48',
        'trade4',
        'markets32',
        'markets11',
        'trade289', //闪兑
        'markets12',
        'markets13',
        'markets14',
        'ETF'
      ];
      quickEntryList.forEach((element) {
        element.list.removeWhere((element) => titles.contains(element.title));
      });
    }
    removeQuickName();
  }

  @override
  void onReady() {
    super.onReady();
    _loadJson();

    update();
  }

  void changeEdit() {
    isEditing = !isEditing;
    update();
    if (!isEditing) {
      FavoriteQuickEntryController.to.save();
    }
  }

  @override
  void onClose() {
    super.onClose();
  }

  removeQuickName() {
    final titles = FavoriteQuickEntryController.to.quickNameSet;
    quickEntryList.forEach((element) {
      element.list.removeWhere((element) => titles.contains(element.title));
    });
  }
}
