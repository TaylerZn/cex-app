import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order_cancel/controllers/customer_order_cancel_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order_cancel/widget/customer_order_cancel_list.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class CustomerOrderCancelView extends GetView<CustomerOrderCancelController> {
  const CustomerOrderCancelView({super.key, this.vc});
  final CustomerOrderCancelController? vc;

  @override
  Widget build(BuildContext context) {
    var cancelVC = vc ?? controller;
    return GetBuilder(
        init: cancelVC,
        builder: (c) {
          return Scaffold(
              appBar: AppBar(
                leading: MyPageBackWidget(onTap: () => cancelVC.goOtherOrder()),
              ),
              body: CustomerOrderCancelListView(controller: cancelVC),
              bottomNavigationBar: getBottomView(context, cancelVC));
        });
  }

  getBottomView(BuildContext context, CustomerOrderCancelController cancelVC) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
        ),
      ),
      child: Container(
          padding: EdgeInsets.all(16.w),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          height: 80.h,
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    cancelVC.goOtherOrder();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColor.colorWhite,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: AppColor.colorABABAB,
                        width: 1,
                      ),
                    ),
                    height: 48.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          LocaleKeys.c2c264.tr,
                          style: AppTextStyle.f_16_600.color111111,
                        ),
                        MyImage(
                          'flow/follow_setup_arrow'.svgAssets(),
                          height: 24.r,
                          width: 24.r,
                          color: AppColor.color111111,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
