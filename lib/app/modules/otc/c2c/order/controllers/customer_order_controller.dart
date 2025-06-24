import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/order/order_detail/controllers/order_detail_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/order/widget/c2c_date_picker_widget.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';

import '../../../../../models/otc/c2c/otc_record.dart';
import '../widget/models/c2c_filter_bean.dart';
import 'order_list_controller.dart';

class CustomerOrderController extends GetxController with GetSingleTickerProviderStateMixin {
  //TODO: Implement CustomerOrderController
  late TabController? tab;
  final count = 0.obs;
  OTCOrderType type = OTCOrderType.all;
  RecordTabType? tabType = RecordTabType.present;
  C2CFilterBean? filterBean;
  bool haveNavBar = false;
  @override
  void onInit() {
    super.onInit();
    haveNavBar = Get.arguments?['isHome'] == false ? true : false;
    tab = TabController(length: 2, vsync: this);
    List<RecordTabType> list = [RecordTabType.present, RecordTabType.finish];
    tab?.addListener(() {
      if (tab?.indexIsChanging == false) {
        tabType = list[tab!.index];
        reloadList();
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  void reloadList({bool clear = false}) {
    OrderDetailController detailController = Get.find<OrderDetailController>(tag: tabType?.key);

    bool isRegistered = Get.isRegistered<OrderListController>(tag: '${tabType?.key}${detailController.curType.title()}');
    if (!isRegistered) {
      return;
    }
    final listController = Get.find<OrderListController>(tag: '${tabType?.key}${detailController.curType.title()}');
    listController.refreshData(false);
  }

  @override
  void onClose() {
    super.onClose();
  }

  void showDateFilter() {
    Get.bottomSheet(
      C2CDatePickerWidget(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void increment() => count.value++;
}
