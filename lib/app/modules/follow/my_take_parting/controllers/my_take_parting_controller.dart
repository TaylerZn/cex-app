import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/data/follow_data.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_parting/model/follow_kol_profit.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_parting/model/follow_kol_set.dart';
import 'package:nt_app_flutter/app/modules/follow/my_take_parting/model/my_parting_enum.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyTakePartingController extends GetxController with GetTickerProviderStateMixin {
  int currentIndex = 0;
  late TabController tabController;
  late FollowKolTraderInfoModel infoModel;
  TextEditingController textVC = TextEditingController();
  TextEditingController textVC2 = TextEditingController();

  final List<MyPartingType> tabs = [MyPartingType.expectedSorted, MyPartingType.historicalSorted];
  var rateStr = ''.obs;
  var rateStr2 = ''.obs;

  var rateStrEnabled = true.obs;
  var rateStr2Enabled = true.obs;

  @override
  void onInit() {
    super.onInit();

    infoModel = Get.arguments['model'];

    tabController = TabController(length: tabs.length, vsync: this);
    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        currentIndex = tabController.index;
        getData();
      }
    });

    textVC.text = infoModel.rate.toString();
    rateStr.value = textVC.text;

    textVC2.text = infoModel.agentProfitRatio.toString();
    rateStr2.value = textVC2.text;

    textVC.addListener(() {
      if (textVC.text.isEmpty) {
        rateStrEnabled.value = false;
      } else {
        rateStrEnabled.value = (num.tryParse(textVC.text) ?? 0) <= infoModel.rateLimit;
      }
    });

    textVC2.addListener(() {
      if (textVC2.text.isEmpty) {
        rateStr2Enabled.value = false;
      } else {
        rateStr2Enabled.value = ((num.tryParse(textVC2.text) ?? 0) <= 100) && ((num.tryParse(textVC2.text) ?? 0) >= 20);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  Rx<FollowkolProfitListModel> currentOrder = FollowkolProfitListModel().obs;
  RefreshController currentOrderRefreshVc = RefreshController();

  Rx<FollowkolSetListModel> historyOrder = FollowkolSetListModel().obs;
  RefreshController historyOrderRefreshVc = RefreshController();

  Future? getData({bool isPullDown = false}) {
    var type = tabs[currentIndex];
    switch (type) {
      case MyPartingType.expectedSorted:
        if (isPullDown) {
          currentOrder.value.page = 1;
        } else {
          if (currentOrder.value.list != null && currentOrder.value.page == 1) return null;
        }
        return AFFollow.getFollowProfitList(page: currentOrder.value.page, pageSize: currentOrder.value.pageSize).then((value) {
          int page = currentOrder.value.page;
          var pageSize = value.list?.length;

          if (page != 1) {
            currentOrder.value.list?.addAll(value.list!);
            value.list = currentOrder.value.list;
          }

          currentOrder.value = value;
          currentOrder.value.page = page;
          currentOrder.value.haveMore = pageSize == currentOrder.value.pageSize;
        });
      default:
        if (isPullDown) {
          historyOrder.value.page = 1;
        } else {
          if (historyOrder.value.list != null && historyOrder.value.page == 1) return null;
        }
        return AFFollow.getFollowSettList(pageNo: historyOrder.value.page, pageSize: historyOrder.value.pageSize).then((value) {
          int page = historyOrder.value.page;
          var pageSize = value.list?.length;

          if (page != 1) {
            historyOrder.value.list?.addAll(value.list!);
            value.list = historyOrder.value.list;
          }

          historyOrder.value = value;
          historyOrder.value.page = page;
          historyOrder.value.haveMore = pageSize == historyOrder.value.pageSize;
        });
    }
  }

  editCommission() {
    AFFollow.postUpdateRato(rate: num.parse(textVC.text)).then((value) {
      if (value == null) {
        rateStr.value = textVC.text;
        infoModel.rate = double.parse(textVC.text);
        UIUtil.showSuccess(LocaleKeys.follow119.tr);
      } else {
        UIUtil.showToast(LocaleKeys.follow120.tr);
      }
    });
  }

  editAgentCommission() {
    AFFollow.postUpdateAgentProfitRatio(rate: num.parse(textVC2.text)).then((value) {
      if (value == null) {
        rateStr2.value = textVC2.text;
        infoModel.agentProfitRatio = double.parse(textVC2.text);
        UIUtil.showSuccess(LocaleKeys.follow119.tr);
      } else {
        UIUtil.showToast(LocaleKeys.follow120.tr);
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
