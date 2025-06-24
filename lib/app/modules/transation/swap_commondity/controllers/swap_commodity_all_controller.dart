import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/commodity/res/commodity_public_info.dart';

import '../../../../models/contract/res/public_info.dart';

class SwapCommodityAllController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static SwapCommodityAllController get to => Get.find();
  List<String> tabs = [];
  late TabController tabController;
  List<List<ContractInfo>> contractGroupList = [];

  @override
  void onInit() {
    tabs = CommodityDataStoreController.to.contractGroupList
        .map((e) => e.kindNameStr)
        .toList();
    _getAll();
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  _getAll() {
    contractGroupList.clear();
    CommodityDataStoreController.to.contractGroupList.forEach((element) {
      List<ContractInfo> list = [];
      element.contractList?.forEach((element) {
        list.add(element);
      });
      contractGroupList.add(list);
    });
  }

  void search(String keyword) {
    try {
      if (keyword.isEmpty) {
        _getAll();
        update();
        return;
      }
      List<List<ContractInfo>> temp = List.from(contractGroupList);
      List<List<ContractInfo>> target = [];
      for (var element in temp) {
        List<ContractInfo> list = [];
        for (var element in element) {
          if (element.symbol.toLowerCase().contains(keyword.toLowerCase())) {
            list.add(element);
          }
        }
        target.add(list);
      }
      contractGroupList = target;
      update();
    } catch (e) {}
  }
}
