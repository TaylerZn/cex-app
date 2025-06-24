import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/models/otc/c2c/otc_apply_info.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/apply/controllers/customer_apply_controller.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_dotted_line.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class ApplyStageWidget extends StatefulWidget {
  final int selectedIndex;
  const ApplyStageWidget({super.key, this.selectedIndex = 0});

  @override
  State<ApplyStageWidget> createState() => _ApplyStageWidgetState();
}

class _ApplyStageWidgetState extends State<ApplyStageWidget> {
  final controller = Get.find<CustomerApplyController>();

  //.login(user);
  // get.find

  Widget buildOption(String index, String title, {bool selected = false}) {
    return Expanded(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        5.h.verticalSpace,
        Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: selected
                  ? null
                  : Border.all(color: AppColor.colorFFFFFF.withOpacity(0.2)),
              color: selected ? AppColor.colorWhite : Colors.transparent,
            ),
            child: Text(index,
                textAlign: TextAlign.center,
                style: selected
                    ? AppTextStyle.f_14_600
                    : AppTextStyle.f_14_600.colorTips)),
        SizedBox(height: 8.h),
        Text(title,
            textAlign: TextAlign.center,
            style: selected
                ? AppTextStyle.f_14_600.colorFFFFFF
                : AppTextStyle.f_14_600.colorTips)
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      radius: Radius.circular(10.r),
      dashPattern: [5, 3],
      color: Colors.white.withOpacity(0.2),
      strokeWidth: 1,
      strokeCap: StrokeCap.square,
      child: ClipRRect(
        //  borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
            alignment: Alignment.center,
            height: 81.h,
            width: 327.w,
            child: Row(
              children: [
                buildOption('1', LocaleKeys.c2c73.tr, selected: true),
                SizedBox(width: 14.w),
                MyDottedLine(
                  lineWidthRatio: 48.w,
                ),
                SizedBox(width: 14.w),
                buildOption('2', LocaleKeys.c2c74.tr,
                    selected: controller.applyInfo?.otcStatus !=
                        OTCApplyStatus.fillForm),
                SizedBox(width: 14.w),
                MyDottedLine(
                  lineWidthRatio: 48.w,
                ),
                SizedBox(width: 14.w),
                buildOption('3', LocaleKeys.c2c75.tr,
                    selected: controller.applyInfo?.otcStatus ==
                            OTCApplyStatus.verifySucces ||
                        controller.applyInfo?.otcStatus ==
                            OTCApplyStatus.revoking),
              ],
            )
            // color: Colors.amber,
            ),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant ApplyStageWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      setState(() {});
    }
  }
}
