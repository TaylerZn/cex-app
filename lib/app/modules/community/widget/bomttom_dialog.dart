import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/regexp_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

class BottomDialog extends StatelessWidget {
  const BottomDialog({super.key, required this.title, required this.content});

  final String title;
  final String content;

  static void show({required String title, required String content}) {
    Get.dialog(
      BottomDialog(title: title, content: content),
      useSafeArea: false, // 允许手动设置 SafeArea
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.w)),
        child: Container(
          color: AppColor.colorBackgroundPrimary,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              20.verticalSpaceFromWidth,
              SizedBox(
                height: 27.w,
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Text(title,
                            style: AppTextStyle.f_18_600.colorTextPrimary)),
                    Positioned(
                      right: 24.w,
                      top: 4.w,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: MyImage(
                          'community/close'.svgAssets(),
                          width: 20.w,
                          height: 20.w,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              20.verticalSpaceFromWidth,
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: Text(content,
                    style: AppTextStyle.f_13_500.colorTextDescription
                        .copyWith(height: 1.5),
                  ),
                ),
                20.verticalSpaceFromWidth,
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).padding.bottom, // 动态处理安全区域的底部
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
