import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../widgets/components/transaction/bottom_sheet/bottom_sheet_util.dart';

class CommunityListBottomSheet extends StatelessWidget {
  const CommunityListBottomSheet(
      {super.key,
      required this.items,
      required this.icons,
      required this.onTapHandlers,
      this.title});

  final String? title;
  final List<String> items;
  final List<String> icons;
  final List<VoidCallback> onTapHandlers;

  static Future<void> show(
      {required List<String> titles,
      required List<String> icons,
      required List<VoidCallback> onTapHandlers}) async {
    await showBSheet<void>(
      CommunityListBottomSheet(
        items: titles,
        icons: icons,
        onTapHandlers: onTapHandlers,
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
              Center(
                child: Container(
                  width: 40.w,
                  height: 5.h,
                  decoration: BoxDecoration(
                    color: AppColor.color999999,
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ).marginOnly(bottom: 16.h),
              if (title != null)
                Text(
                  title!,
                  style: AppTextStyle.f_20_600.color111111,
                ).marginOnly(bottom: 20.h),
              ListView.builder(
                itemCount: items.length,
                padding: EdgeInsets.zero,
                // shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return botomSheetbuildTitle(
                      items[index], icons[index], onTapHandlers[index],
                      isDelete:
                          items[index] == LocaleKeys.community11.tr); //'删除'
                },
              ),
            ],
          ),
        ),
        Divider(
          height: 1.h,
          color: AppColor.colorF5F5F5,
        ).marginSymmetric(vertical: 16.h),
        // MyOutLineButton(title: LocaleKeys.public2.tr, onTap: () => Get.back()),
        16.verticalSpace,
      ],
    );
  }
}

Widget botomSheetbuildTitle(String title, String iconPath, VoidCallback onTap,
    {bool isDelete = false}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 36.h,
      alignment: Alignment.center,
      child: Row(
        children: [
          MyImage(iconPath, width: 36.w),
          SizedBox(width: 12.w),
          Text(
            title,
            style: TextStyle(
              color: isDelete ? AppColor.colorDanger : AppColor.color111111,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}

/*
CommunityListBottomSheet.show(
  titles: ['收藏', '从个人资料中取消置顶', '分享', '删除'],
  icons: ['assets/icons/star', 'assets/icons/push_pin', 'assets/icons/share', 'assets/icons/delete'],
  onTapHandlers: [
    () {
      print('收藏 tapped');
      Get.back();
    },
    () {
      print('从个人资料中取消置顶 tapped');
      Get.back();
    },
    () {
      print('分享 tapped');
      Get.back();
    },
    () {
      print('删除 tapped');
      // 在此处添加删除操作
      Get.back();
    },
  ],
);
* */
