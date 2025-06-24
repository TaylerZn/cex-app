import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/widget/comission_desc_widget.dart';

import 'package:nt_app_flutter/app/modules/otc/c2c/my/widget/comission_header_widget.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/widget/comission_limit_widget.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/widget/comission_method_widget.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/widget/comission_price_range_widget.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/widget/comission_price_widget.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/widget/comission_reply_widget.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/widget/comission_unit_widget.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/widget/footer_widget.dart';
import 'package:nt_app_flutter/app/utils/utilities/app_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../controllers/sales_comission_controller.dart';

class SalesComissionView extends GetView<SalesComissionController> {
  const SalesComissionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(controller.actiontitle),
          leading: const MyPageBackWidget(),
          centerTitle: true,
        ),
        body: GestureDetector(
          onTap: () {
            AppUtil.hideKeyboard(context);
          },
          child: GetBuilder<SalesComissionController>(builder: (controller) {
            return SmartRefresher(
              controller: controller.refreshVC,
              enablePullDown: true,
              onRefresh: () async {
                await controller.loadData(isOnrRady: false);
                controller.refreshVC.refreshToIdle();
                controller.refreshVC.loadComplete();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Expanded(
                    //     child:

                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16.h),
                              ComissionHeaderWidget(),
                              SizedBox(height: 20.h),
                              CommissionUnitWidget(),
                              SizedBox(height: 20.h),
                              CommissionPriceWidget(),
                              SizedBox(height: 20.h),
                              ComissionPriceRangeWidget(),
                              SizedBox(height: 20.h),
                              ComissionMethodWidget(),
                              SizedBox(height: 20.h),
                              ComissionLimitWidget(),
                              SizedBox(height: 20.h),
                              ComissionDescWidget(),
                              SizedBox(height: 20.h),
                              ComissionReplyWidget(),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        )),

                    // ),
                  ],
                ),
              ),
            );
          }),
        ),
        bottomNavigationBar: CustomerFooterWidget(
            text: controller.actiontitle,
            onTap: () {
              controller.startPublish();
            }));
  }
}
