import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import 'bottom_sheet_util.dart';

class CommonBottomSheet extends StatelessWidget {
  const CommonBottomSheet(
      {super.key,
      required this.items,
      required this.selectedIndex,
      this.title});

  final String? title;
  final List<String> items;
  final int selectedIndex;

  static Future<int?> show(
      {required List<String> titles, required int selectedIndex}) async {
    return await showBSheet<int>(
      CommonBottomSheet(
        items: titles,
        selectedIndex: selectedIndex,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Text(
                  title!,
                  style: AppTextStyle.f_20_600.color111111,
                ).marginOnly(bottom: 20.h),
              ListView.builder(
                itemCount: items.length,
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return bottomSheetBuildTitle(
                    items[index],
                    index == selectedIndex,
                    () {
                      Get.back(result: index);
                    },
                  );
                },
              ),
            ],
          ),
        ),
        const Divider(
          height: 0.5,
          color: AppColor.colorBorderGutter,
        ).marginSymmetric(vertical: 16.h),
        MyButton(
          text: LocaleKeys.public2.tr,
          border: Border.all(color: AppColor.colorBorderStrong, width: 1),
          color: AppColor.colorTextPrimary,
          backgroundColor: AppColor.colorAlwaysWhite,
          onTap: () => Get.back(),
          height: 48.h,
        ).marginSymmetric(horizontal: 16.w),
        16.verticalSpace,
      ],
    );
  }
}

Widget bottomSheetBuildTitle(String title, bool isSelected, VoidCallback onTap,
    [String? des]) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      height: 44.h,
      alignment: Alignment.center,
      decoration: isSelected
          ? BoxDecoration(
              color: AppColor.colorF5F5F5,
              borderRadius: BorderRadius.circular(4.w),
            )
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColor.color111111,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          4.horizontalSpace,
          if (des != null)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              margin: EdgeInsets.only(right: 4.w),
              decoration: ShapeDecoration(
                color: AppColor.colorF3F3F3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              child: Text(
                des,
                style: AppTextStyle.f_10_500.copyWith(
                  color: AppColor.color4D4D4D,
                ),
              ),
            ),
          const Spacer(),
          if (isSelected)
            Icon(
              Icons.check,
              color: AppColor.color111111,
              size: 20.w,
            ),
        ],
      ),
    ),
  );
}
