import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/sales_comission/controllers/sales_comission_controller.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_textField.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class CommissionUnitWidget extends StatefulWidget {
  final Function(String value)? onChanged;
  const CommissionUnitWidget({super.key, this.onChanged});

  @override
  State<CommissionUnitWidget> createState() => _CommissionUnitWidgetState();
}

class _CommissionUnitWidgetState extends State<CommissionUnitWidget> {
  final controller = Get.find<SalesComissionController>();
  TextEditingController tc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            controller.isPurchaseMode
                ? LocaleKeys.c2c22.tr
                : LocaleKeys.c2c28.tr,
            style: AppTextStyle.f_15_500),
        SizedBox(height: 4.h),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(6.r)),
              border: Border.all(color: AppColor.colorF5F5F5)),
          child: Row(
            children: [
              Expanded(
                  child: MyTextFieldWidget(
                      controller: tc,
                      onChanged: (value) {
                        controller.formFill.volume = value;
                      },
                      enabledBorderColor: Colors.transparent,
                      inputFormatters: [
                        // NumericalRangeFormatter(min: OtcConfigUtils().minValue,max: OtcConfigUtils().maxValue),
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      hintText: controller.isPurchaseMode
                          ? LocaleKeys.c2c185.tr
                          : LocaleKeys.c2c29.tr,
                      isTopText: false,
                      focusedBorderColor: Colors.transparent,
                      keyboardType: TextInputType.number)),
              SizedBox(width: 16.w),
              Text('USDT', style: AppTextStyle.f_13_500.color666666),
              SizedBox(width: 16.w),
              MyButton(
                  text: LocaleKeys.b2c5.tr,
                  backgroundColor: Colors.transparent,
                  color: AppColor.color0075FF,
                  textStyle:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 13.sp),
                  onTap: () {
                    tc.text = '${controller.tradeMaxValue}';
                    controller.formFill.volume = '${controller.tradeMaxValue}';
                  }),
              SizedBox(width: 16.w)
            ],
          ),
        )
      ],
    );
  }
}
