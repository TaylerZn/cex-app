import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/otc/b2c/main/views/b2c_view.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/main/widget/customer_main_top.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/customer/views/customer_index_view.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import '../../order/controllers/customer_order_controller.dart';
import '../controllers/customer_main_controller.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';

class CustomerMainView extends GetView<CustomerMainController> {
  const CustomerMainView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (c) {
          return OtcConfigUtils().publicInfo == null
              ? const FollowOrdersLoading(isSliver: false)
              : Scaffold(
                  appBar: AppBar(
                    leading: const MyPageBackWidget(),
                    title: CustomerMainNav(
                      controller: controller,
                      callback: (p) {
                        controller.type.value = p == 0 ? MainViewType.quick : MainViewType.option;

                        controller.pageController.animateToPage(
                          p,
                          duration: const Duration(milliseconds: 1),
                          curve: Curves.easeInOut,
                        );

                        controller.update();
                      },
                    ),
                    centerTitle: true,
                  ),
                  body: PageView(
                      controller: controller.pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: OtcConfigUtils().haveC2C
                          ? [
                              B2cView(currency: controller.currency),
                              CustomerIndexView(
                                callback: (p0) {
                                  if (p0 == 0) {
                                    controller.type.value = MainViewType.option;
                                  } else if (p0 == 1) {
                                    if (controller.type.value != MainViewType.order) {
                                      if (Get.isRegistered<CustomerOrderController>()) {
                                        Get.find<CustomerOrderController>().reloadList(clear: true);
                                      }
                                    }
                                    controller.type.value = MainViewType.order;
                                  } else {
                                    controller.type.value = MainViewType.other;
                                  }
                                },
                              )
                            ]
                          : [const B2cView()]));
        });
  }
}
