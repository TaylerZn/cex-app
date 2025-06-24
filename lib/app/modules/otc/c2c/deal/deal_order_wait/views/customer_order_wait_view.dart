import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order_appeal/controllers/customer_order_appeal_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order_appeal/views/customer_order_appeal_view.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order_cancel/controllers/customer_order_cancel_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order_cancel/views/customer_order_cancel_view.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order_wait/controllers/customer_order_wait_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/deal/deal_order_wait/widget/customer_order_wait_list.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class CustomerOrderWaitView extends GetView<CustomerOrderWaitController> {
  const CustomerOrderWaitView({super.key, this.vc});

  final CustomerOrderWaitController? vc;

  @override
  Widget build(BuildContext context) {
    var waitVC = vc ?? controller;

    return GetBuilder(
        init: waitVC,
        builder: (c) {
          return waitVC.model.detailModel.status == 4
              ? CustomerOrderCancelView(
                  vc: CustomerOrderCancelController(
                      argModel: waitVC.model, argNum: waitVC.idNum))
              : waitVC.model.detailModel.status == 5
                  ? CustomerOrderAppealView(
                      vc: CustomerOrderAppealController(
                          argModel: waitVC.model, argNum: waitVC.idNum))
                  : Scaffold(
                      appBar: AppBar(
                          leading: MyPageBackWidget(
                              onTap: () => waitVC.goOtherOrder())),
                      body: CustomerOrderWaitListView(controller: waitVC),
                      bottomNavigationBar: getBottom(context, waitVC));
        });
  }

  Widget getBottom(context, CustomerOrderWaitController controller) {
    return controller.model.detailModel.sequence == null
        ? const SizedBox()
        : DecoratedBox(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                    padding: EdgeInsets.all(16.w),
                    margin: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom,
                    ),
                    height: 80.h,
                    child: controller.model.detailModel.status! > 2
                        ? Row(
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    controller.goAsset();
                                  },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 24.w),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          LocaleKeys.c2c302.tr,
                                          style:
                                              AppTextStyle.f_16_600.color111111,
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
                          )
                        : Row(
                            children: [
                              Expanded(
                                child: MyButton.borderWhiteBg(
                                  onTap: () {
                                    controller.cacelOrder();
                                  },
                                  height: 48.h,
                                  text: LocaleKeys.c2c303.tr,
                                  border: Border.all(
                                      width: 1, color: AppColor.colorABABAB),
                                ),
                              ),
                              SizedBox(width: 7.w),
                              Expanded(
                                child: MyButton.borderWhiteBg(
                                  onTap: () {
                                    controller.goOrderAppeal();
                                  },
                                  height: 48.h,
                                  text: LocaleKeys.c2c149.tr,
                                  border: Border.all(
                                      width: 1, color: AppColor.colorABABAB),
                                ),
                              ),
                            ],
                          )),
              ],
            ),
          );
  }
}

// DecoratedBox(
//                 decoration: const BoxDecoration(
//                   border: Border(
//                     top: BorderSide(width: 1.0, color: AppColor.colorEEEEEE),
//                   ),
//                 ),
//                 child: Container(
//                     padding: EdgeInsets.all(16.w),
//                     margin: EdgeInsets.only(
//                       bottom: MediaQuery.of(context).padding.bottom,
//                     ),
//                     height: 80.h,
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: GestureDetector(
//                             onTap: () {
//                               controller.goOtherOrder();
//                             },
//                             child: Container(
//                                 alignment: Alignment.center,
//                                 decoration: BoxDecoration(
//                                   color: AppColor.colorWhite,
//                                   borderRadius: BorderRadius.circular(6),
//                                   border: Border.all(
//                                     color: AppColor.colorABABAB,
//                                     width: 1,
//                                   ),
//                                 ),
//                                 height: 48.h,
//                                 child: Text('產看其他广告', style: AppTextStyle.body_600.color111111)),
//                           ),
//                         ),
//                       ],
//                     )),
//               )
