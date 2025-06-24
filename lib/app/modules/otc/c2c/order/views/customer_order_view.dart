import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_record.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/order/order_detail/controllers/order_detail_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/order/order_detail/views/order_detail_view.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_tab_underline_widget.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/customer_order_controller.dart';

class CustomerOrderView extends GetView<CustomerOrderController> {
  const CustomerOrderView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: controller.haveNavBar
            ? AppBar(
                title: Text(LocaleKeys.c2c145.tr),
                leading: MyPageBackWidget(),
              )
            : null,
        body: Column(children: [
          _buildTabBar(),
          16.verticalSpace,
          Expanded(
              child: TabBarView(
                  controller: controller.tab,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                KeepAliveWrapper(
                    child: GetBuilder<OrderDetailController>(
                        init:
                            OrderDetailController(index: RecordTabType.present),
                        tag: RecordTabType.present.key,
                        builder: (controller) {
                          return OrderDetailView(
                              tabType: RecordTabType.present);
                        })),
                KeepAliveWrapper(
                    child: GetBuilder<OrderDetailController>(
                        init:
                            OrderDetailController(index: RecordTabType.finish),
                        tag: RecordTabType.finish.key,
                        builder: (controller) {
                          return OrderDetailView(tabType: RecordTabType.finish);
                        }))
              ])),
        ]));
  }

  Widget _buildTabBar() {
    return Row(
      children: [
        Expanded(
            child: Container(
          height: 40.h,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            // color: themeData.scaffoldBackgroundColor,
            border: Border(
              bottom: BorderSide(
                color: AppColor.colorF5F5F5,
                width: 1.w,
              ),
            ),
          ),
          child: GetBuilder<UserGetx>(builder: (userGetx) {
            return Row(
              children: [
                4.horizontalSpace,
                TabBar(
                  onTap: (index) {},
                  controller: controller.tab,
                  isScrollable: true,
                  indicator: const MyUnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 2,
                      color: AppColor.color111111,
                    ),
                  ),
                  labelColor: AppColor.color111111,
                  unselectedLabelColor: AppColor.colorABABAB,
                  labelStyle: AppTextStyle.f_14_500,
                  unselectedLabelStyle: AppTextStyle.f_14_500,
                  tabAlignment: TabAlignment.start,
                  tabs: [
                    Tab(text: LocaleKeys.c2c177.tr), //手续费返佣
                    Tab(
                      text: LocaleKeys.c2c178.tr, //邀请用户
                    ),
                  ],
                ),
              ],
            );
          }),
        )),
        InkWell(
          onTap: () {
            controller.showDateFilter();
          },
          child: MyImage(
            'otc/c2c/c2c_filter'.svgAssets(),
            width: 14.w,
            color: AppColor.color111111,
          ),
        ),
        16.horizontalSpace
      ],
    );
  }
}
