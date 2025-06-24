// ignore_for_file: empty_catches

import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/global/favorite/commodity_favorite_controller.dart';

import '../../../../global/dataStore/commodity_data_store_controller.dart';
import '../../../../models/contract/res/public_info.dart';
import '../../../../utils/bus/event_bus.dart';
import '../../../../utils/bus/event_type.dart';

class SwapCommodityOptionController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static SwapCommodityOptionController get to => Get.find();

  List<String> tabs = [];
  late TabController tabController;
  List<List<ContractInfo>> contractList = [];
  LinkedHashMap<String, List<ContractInfo>> recommendContract = LinkedHashMap();

  @override
  void onInit() {
    tabs = [];

    /// 自选合约
    _getOption();
    tabController = TabController(length: tabs.length, vsync: this);
    super.onInit();

    Bus.getInstance().on(EventType.refreshCommodityOption, (data) {
      _getOption();
      update();
    });
  }

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  _getOption() {
    /// 自选合约
    for (var element in CommodityDataStoreController.to.contractGroupList) {
      tabs.add(element.kindNameStr);
      List<ContractInfo> list = [];
      element.contractList?.forEach((element) {
        if (CommodityOptionController.to.isOption(element.id)) {
          list.add(element);
        }
      });
      contractList.add(list);
      recommendContract[element.kindNameStr] = element.contractList == null
          ? []
          : element.contractList!
              .sublist(0, min(6, element.contractList!.length));
    }
  }

  _getAll() {
    tabs = [];
    contractList = [];
    for (var element in CommodityDataStoreController.to.contractGroupList) {
      tabs.add(element.kindNameStr);
      List<ContractInfo> list = [];
      element.contractList?.forEach((element) {
        if (CommodityOptionController.to.isOption(element.id)) {
          list.add(element);
        }
      });
      contractList.add(list);
    }
  }

  @override
  void onClose() {
    tabController.dispose();
    Bus.getInstance().off(EventType.refreshCommodityOption, (data) {});
    super.onClose();
  }

  void search(String keyword) {
    try {
      if (keyword.isEmpty) {
        _getAll();
        update();
        return;
      }

      List<List<ContractInfo>> temp = List.from(contractList);
      List<List<ContractInfo>> target = [];

      for (var i = 0; i < temp.length; i++) {
        List<ContractInfo> list = [];
        for (var element in temp[i]) {
          if (element.symbol.toLowerCase().contains(keyword.toLowerCase())) {
            list.add(element);
          }
        }
        target.add(list);
      }
      contractList = target;
      update();
    } catch (e) {}
  }
}
