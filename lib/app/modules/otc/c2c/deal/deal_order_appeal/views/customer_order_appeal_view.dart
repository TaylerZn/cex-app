import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order_appeal/controllers/customer_order_appeal_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order_appeal/widget/customer_order_appeal_list.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';

class CustomerOrderAppealView extends GetView<CustomerOrderAppealController> {
  const CustomerOrderAppealView({super.key, this.vc});
  final CustomerOrderAppealController? vc;
  @override
  Widget build(BuildContext context) {
    var appearVc = vc ?? controller;
    return GetBuilder(
        init: appearVc,
        assignId: true,
        builder: (c) {
          return Scaffold(
              appBar: AppBar(leading: MyPageBackWidget(onTap: () => appearVc.goOtherOrder())),
              body: CustomerOrderAppeallListView(controller: appearVc),
              bottomNavigationBar: CustomerDealAppealBottomView(controller: appearVc));
        });
  }
}
