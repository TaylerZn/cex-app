import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/widgets/follow_orders_tabbar.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/model/customer_model.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/wideget/Customer_toc_list.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/wideget/Customer_toc_sheet.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/home/wideget/Customer_toc_top.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/guide/guide_index_view.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../controllers/customer_toc_controller.dart';

class CustomerTocView extends GetView<CustomerTocController> {
  const CustomerTocView({super.key});
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverToBoxAdapter(
              child: FollowOrdersTabbar(
                  marginTop: 0,
                  marginBottom: 26,
                  labelStyle: AppTextStyle.f_18_600,
                  unselectedLabelStyle: AppTextStyle.f_18_600,
                  height: 35,
                  radius: 32,
                  labelPadding: 14,
                  rightWidget: Container(
                      margin: EdgeInsets.only(right: 16.w),
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: AppColor.colorEEEEEE),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          if (controller.requestModel.value.complete) {
                            showCustomerTocSheetView(
                                controller.requestModel.value,
                                bottomType: CustomerSheetType.rateType);
                          }
                        },
                        child: Row(
                          children: [
                            Obx(() => Text(
                                    controller.requestModel.value.filterRate
                                        .topTitle.value,
                                    style: AppTextStyle.f_14_500.color111111)
                                .marginOnly(bottom: 2.h)),
                            const SizedBox(width: 4),
                            MyImage(
                              'otc/c2c/c2c_change'.svgAssets(),
                              width: 10.w,
                              height: 10.w,
                            ),
                          ],
                        ),
                      )),
                  controller: controller.tabController,
                  dataArray: controller.navTabs.map((e) => e.value).toList()),
            ),
            SliverPinnedHeader(
                child: AppGuideView(
                    order: 2,
                    guideType: AppGuideType.c2c,
                    child: CustomerTocTopView(controller: controller))),
          ];
        },
        body: TabBarView(
            controller: controller.tabController,
            children: controller.navTabs.map((type) {
              return CustomerTocListView(type: type, controller: controller);
            }).toList()));
  }
}
