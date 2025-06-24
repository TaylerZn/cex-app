import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order/widget/customer_deal_order_list.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order_wait/controllers/customer_order_wait_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order_wait/views/customer_order_wait_view.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../controllers/customer_deal_order_controller.dart';

class CustomerDealOrderView extends GetView<CustomerDealOrderController> {
  const CustomerDealOrderView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: controller,
        builder: (c) {
          return controller.model.detailModel.status != null &&
                  controller.model.detailModel.status! > 2
              ? CustomerOrderWaitView(
                  vc: CustomerOrderWaitController(
                      argModel: controller.model, argNum: controller.idNum))
              : Scaffold(
                  appBar: AppBar(
                      leading: MyPageBackWidget(
                          onTap: () => controller.goOtherOrder())),
                  body: CustomerDealOrderListView(controller: controller),
                  bottomNavigationBar: getBottomView(context));
        });
  }

  Widget getBottomView(context) {
    return DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
          ),
        ),
        child: controller.model.detailModel.sequence == null
            ? const SizedBox()
            : controller.model.detailModel.isBUy
                ? Container(
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
                              controller.cacelOrder();
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
                                child: Text(LocaleKeys.c2c226.tr,
                                    style: AppTextStyle.f_16_600.color111111)),
                          ),
                        ),
                        SizedBox(width: 7.w),
                        Expanded(
                          child: GestureDetector(
                              onTap: () {
                                controller.goOrderTrade();
                              },
                              child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: AppColor.color111111,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  height: 48.h,
                                  child: Text(LocaleKeys.c2c227.tr,
                                      style: AppTextStyle.f_16_600.copyWith(
                                          color: AppColor.colorWhite)))),
                        ),
                      ],
                    ))
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                          // height: 34.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 10.w),
                          decoration: const BoxDecoration(
                            color: Color(0x19F6465D),
                            // color: Colors.amber
                          ),
                          child: Text(LocaleKeys.c2c274.tr,
                              style: AppTextStyle.f_11_400.colorF53F57)),
                      Container(
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
                                    Get.toNamed(Routes.ASSISTANCE, arguments: {
                                      'id': controller.idNum,
                                      'model': controller.model.detailModel
                                    });
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
                                      child: Text(LocaleKeys.c2c297.tr,
                                          style: AppTextStyle
                                              .f_16_600.color111111)),
                                ),
                              ),
                              SizedBox(width: 7.w),
                              Expanded(
                                  child: controller.model.detailModel.status ==
                                          2
                                      ? GestureDetector(
                                          onTap: () {
                                            controller.sellOrder();
                                          },
                                          child: Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                color: AppColor.color111111,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              height: 48.h,
                                              child: Text(
                                                  LocaleKeys.c2c269.tr, //已收到
                                                  style: AppTextStyle.f_16_600
                                                      .copyWith(
                                                          color: AppColor
                                                              .colorWhite))))
                                      : Container(
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            color: AppColor.colorCCCCCC,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                          height: 48.h,
                                          child: Text(LocaleKeys.c2c268.tr, //等待
                                              style: AppTextStyle.f_16_600
                                                  .copyWith(
                                                      color: AppColor
                                                          .colorWhite))))
                            ],
                          )),
                    ],
                  ));

    ;
  }
}
