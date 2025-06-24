import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/input_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_textField.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../sales_comission/controllers/sales_comission_controller.dart';

class ComissionPriceRangeWidget extends StatefulWidget {
  const ComissionPriceRangeWidget({super.key});

  @override
  State<ComissionPriceRangeWidget> createState() =>
      _ComissionPriceRangeWidgetState();
}

class _ComissionPriceRangeWidgetState extends State<ComissionPriceRangeWidget> {
  final controller = Get.find<SalesComissionController>();

  @override
  void initState() {
    OtcConfigUtils().payTitle.value = 'USD';
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.c2c33.tr, style: AppTextStyle.f_15_500),
        SizedBox(height: 4.h),
        Row(
          children: [
            buildPriceWidget(0, LocaleKeys.c2c34.tr),
            SizedBox(width: 4.w),
            MyImage('default/go_arrow'.svgAssets(),
                width: 12.w, color: AppColor.color111111),
            SizedBox(width: 3.w),
            buildPriceWidget(1, LocaleKeys.c2c35.tr),
          ],
        )
      ],
    );
  }

  Widget buildPriceWidget(int type, String hintText) {
    return Container(
      width: 156.w,
      // height: 52.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6.r)),
          border: Border.all(color: AppColor.colorF5F5F5)),
      child: Obx(
        () => Row(children: [
          Expanded(
              child: MyTextFieldWidget(
                  inputFormatters: [
                DecimalTextInputFormatter(
                    decimalRange: OtcConfigUtils().decimalPoint,
                    activatedNegativeValues: false)
              ],
                  enabledBorderColor: Colors.transparent,
                  hintStyle: AppTextStyle.f_15_500.colorABABAB,
                  hintText: hintText,
                  isTopText: false,
                  focusedBorderColor: Colors.transparent,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (type == 0) {
                      controller.formFill.minTrade = value;
                    } else {
                      controller.formFill.maxTrade = value;
                    }
                  })),
          SizedBox(width: 10.w),
          Text('${OtcConfigUtils().payTitle}',
              style: AppTextStyle.f_13_500.color666666),
          SizedBox(width: 10.w),
        ]),
      ),
    );
  }
}
