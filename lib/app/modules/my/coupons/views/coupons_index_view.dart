import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/my/coupons/widgets/coupons_list_view.dart';
import 'package:nt_app_flutter/app/modules/transation/entrust/widgets/entrust_tabbar.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import '../controllers/coupons_index_controller.dart';

class CouponsIndexView extends GetView<CouponsIndexController> {
  const CouponsIndexView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const MyPageBackWidget(),
          centerTitle: true,
          title: Text(LocaleKeys.user264.tr),
          actions: [
            GestureDetector(
              onTap: () {
                Get.toNamed(Routes.WEBVIEW, arguments: {'url': LinksGetx.to.couponRules});
              },
              child:
                  Center(child: Text(LocaleKeys.user265.tr, style: AppTextStyle.f_14_500.color666666).paddingOnly(right: 16.w)),
            )
          ],
        ),
        body: GetBuilder<CouponsIndexController>(builder: (c) {
          return controller.complete
              ? Column(
                  children: [
                    EntrustTabbar(
                      dataArray: controller.navTabsStr,
                      controller: controller.tabController,
                      haveTopBorder: false,
                      haveBottomBorder: true,
                      isCenter: true,
                    ),
                    Expanded(
                      child: TabBarView(
                          controller: controller.tabController,
                          children: controller.navTabs.map((type) {
                            return CouponsListView(controller: controller, type: type);
                          }).toList()),
                    ),
                  ],
                )
              : const FollowOrdersLoading(isSliver: false);
        }));
  }
}
