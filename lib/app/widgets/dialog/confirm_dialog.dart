import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final Function? confirmCallback;
  const ConfirmDialog({super.key, required this.title, this.confirmCallback});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 238.w,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6.r)),
            color: AppColor.colorWhite),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: AppTextStyle.f_16_500.color111111),
            16.h.verticalSpace,
            Row(
              children: [
                Expanded(
                    child: MyButton(
                  height: 44.h,
                  onTap: () {
                    Get.back();
                  },
                  text: LocaleKeys.public2.tr,
                  color: AppColor.color111111,
                  textStyle: AppTextStyle.f_14_500,
                  backgroundColor: AppColor.colorF5F5F5,
                )),
                10.w.horizontalSpace,
                Expanded(
                    child: MyButton(
                  height: 44.h,
                  onTap: () {
                    Get.back();
                    confirmCallback?.call();
                  },
                  text: LocaleKeys.public57.tr,
                  textStyle: AppTextStyle.f_14_500,
                  color: AppColor.colorWhite,
                  backgroundColor: AppColor.color111111,
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
