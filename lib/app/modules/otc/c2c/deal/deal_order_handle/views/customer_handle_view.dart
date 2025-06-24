import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order_handle/widget/customer_handle_list.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/customer_handle_controller.dart';

class CustomerOrderHandleView extends GetView<CustomerOrderHandleController> {
  const CustomerOrderHandleView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (c) {
          return Scaffold(
              appBar: AppBar(
                  leading:
                      MyPageBackWidget(onTap: () => controller.goOtherOrder())),
              body: CustomerOrderHandelListView(controller: controller),
              bottomNavigationBar: getBottomView(context));
        });
  }

  Widget getBottomView(BuildContext context) {
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
                    controller.goOrderhelp();
                  },
                  child: Container(
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
                      child: Text(LocaleKeys.c2c300.tr,
                          style: AppTextStyle.f_16_600.color111111)),
                ),
              ),
              SizedBox(width: 7.w),
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      controller.goOrderWait();
                    },
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.color111111,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        height: 48.h,
                        child: Text(LocaleKeys.c2c301.tr,
                            style: AppTextStyle.f_16_600
                                .copyWith(color: AppColor.colorWhite)))),
              ),
            ],
          )),
    );
  }
}
