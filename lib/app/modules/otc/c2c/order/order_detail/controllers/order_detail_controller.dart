import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/api/otc/otc.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/order/controllers/customer_order_controller.dart';
import 'package:nt_app_flutter/app/widgets/basic/list_view/get_list_controller.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../../models/otc/c2c/otc_record.dart';

class OrderDetailController extends GetxController  with GetSingleTickerProviderStateMixin{
  //TODO: Implement OrderDetailController
  late TabController? tab;
  RecordTabType? index;
  List<OTCOrderType> list = [];
  OrderDetailController({ this.index});

  // Selected cover value
  final ValueNotifier<OtcRecord?> record = ValueNotifier<OtcRecord?>(null);
  List<OTCOrderType> get typeList =>  index == RecordTabType.finish ? [OTCOrderType.all,OTCOrderType.completed,OTCOrderType.canceled
  ] : [OTCOrderType.all,OTCOrderType.notPay,OTCOrderType.paid,OTCOrderType.complain];


  OTCOrderType get curType => typeList[tab?.index ?? 0];

  @override
  void onInit() {
    super.onInit();
    list = typeList;
    tab =   TabController(length: list.length, vsync: this);
    tab?.addListener(() {
      if (tab?.indexIsChanging == false) {
        OTCOrderType otcOrderType  =  list[tab?.index ?? 0];
        Get.find<CustomerOrderController>().type = otcOrderType;
        Get.find<CustomerOrderController>().reloadList();
      }
    });
  }

  @override
  void onClose() {
    tab?.dispose();
    super.onClose();
  }

}
