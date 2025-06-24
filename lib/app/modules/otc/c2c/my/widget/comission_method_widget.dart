import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/sales_comission/controllers/sales_comission_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/order/widget/select_option_widget.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../models/otc/c2c/payment_info.dart';

class ComissionMethodWidget extends StatefulWidget {
  const ComissionMethodWidget({super.key});

  @override
  State<ComissionMethodWidget> createState() => _ComissionMethodWidgetState();
}

class _ComissionMethodWidgetState extends State<ComissionMethodWidget> {
  final controller = Get.find<SalesComissionController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
            controller.isPurchaseMode
                ? LocaleKeys.c2c172.tr
                : LocaleKeys.c2c36.tr,
            style: AppTextStyle.f_16_500),
        SizedBox(height: 16.h),
        ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.paymentList?.length ?? 0,
            itemBuilder: (context, index) {
              PaymentInfo? info = controller.paymentList?[index];

              return InkWell(
                onTap: () {
                  if (controller.formFill.payments?.contains(info?.id) ==
                      true) {
                    if (controller.formFill.payments?.length == 1) {
                      return;
                    }
                    setState(() {
                      controller.formFill.payments?.remove(info?.id);
                    });
                    return;
                  }
                  setState(() {
                    controller.formFill.payments?.add(info?.id);
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6.r)),
                      border: Border.all(
                        color: AppColor.colorEEEEEE,
                      )),
                  margin: EdgeInsets.only(bottom: 16.h),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  height: 78.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 4.w),
                                  width: 3.w,
                                  height: 9.h,
                                  decoration: const BoxDecoration(
                                    color: AppColor.color3B85E1,
                                  )),
                              Text(info?.bankName ?? '-',
                                  style: AppTextStyle.f_15_500.color0C0D0F)
                            ],
                          ),
                          SizedBox(height: 6.h),
                          Text(info?.cryptoAccount ?? '-',
                              style: AppTextStyle.f_12_500.color4D4D4D),
                        ],
                      ),
                      SelectOptionWidget(
                          selected: controller.formFill.payments
                                  ?.contains(info?.id) ==
                              true)
                    ],
                  ),
                ),
              );
            }),
        Visibility(
            visible: (controller.paymentList?.length ?? 0) <= 5,
            child: MyButton(
                height: 60.h,
                backgroundColor: AppColor.colorWhite,
                border: Border.all(color: AppColor.colorEEEEEE),
                child: InkWell(
                  onTap: () async {
                    Get.toNamed(Routes.PAYMENT_CHANNEL,
                        arguments: {'isReceiver': !controller.isPurchaseMode});
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            controller.isPurchaseMode
                                ? LocaleKeys.c2c49.tr
                                : LocaleKeys.c2c37.tr,
                            style: AppTextStyle.f_14_500),
                        Icon(Icons.add)
                      ],
                    ),
                  ),
                )))
      ],
    );
  }
}
