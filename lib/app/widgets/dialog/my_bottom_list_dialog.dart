import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/bottom_sheet_util.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

// 通用底部list类型
enum MyBottomListType { select, other }

Future<int> showMyBottomListDialog(
    {required dataList,
    required int initIndex,
    required String Function(dynamic) getDisplayText,
    bool isHideInit = false,
    Color itemBackColor = AppColor.colorWhite,
    EdgeInsetsGeometry? itemPadding,
    String? title,
    MyBottomListType type = MyBottomListType.select}) async {

  return await showBSheet(
       Container(
        decoration: BoxDecoration(
          color: AppColor.colorWhite,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            3.verticalSpace,
            title != null
                ? Text(
                    title,
                    style: AppTextStyle.f_20_600,
                  ).marginSymmetric(horizontal: 16.w).marginOnly(top: 16.w)
                : 0.verticalSpace,
            16.verticalSpace,
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: dataList.length,
              itemBuilder: (BuildContext context, int index) {
                return isHideInit == true && index == initIndex
                    ? const SizedBox()
                    : InkWell(
                        onTap: () {
                          Get.back(result: index);
                        },
                        child: Container(
                          padding: itemPadding ??
                              EdgeInsets.symmetric(
                                  vertical: 12.h, horizontal: 10.w),
                          margin: EdgeInsets.only(
                              bottom: index != dataList.length - 1 ? 12.h : 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.r),
                              color: index == initIndex
                                  ? AppColor.colorF5F5F5
                                  : itemBackColor),
                          child: DecoratedBox(
                            decoration:
                                const BoxDecoration(color: Colors.transparent),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                      getDisplayText(
                                          dataList[index]), // 使用函数获取显示文本
                                      style: AppTextStyle.f_15_600),
                                ),
                                8.horizontalSpace,
                                type == MyBottomListType.select
                                    ? index == initIndex
                                        ? MyImage(
                                            'default/selected'.svgAssets(),
                                            width: 16.w,
                                          )
                                        : SizedBox(
                                            width: 16.w,
                                          )
                                    : MyImage(
                                        'default/go'.svgAssets(),
                                        width: 16.w,
                                        height: 16.w,
                                      )
                              ],
                            ),
                          ),
                        ),
                      );
              },
            ),
            30.verticalSpace,
            const Divider(),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: MyButton.outline(
                text: LocaleKeys.public2.tr,
                height: 48.w,
                color: AppColor.color111111,
                backgroundColor: AppColor.colorFFFFFF,
                textStyle: TextStyle(
                  fontSize: 16.sp,
                  color: AppColor.color111111,
                  fontWeight: FontWeight.w600,
                ),
                onTap: () {
                  Get.back();
                },
              ),
            ),
          ],
        ),
      ),
  );

}
