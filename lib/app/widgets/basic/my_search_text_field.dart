import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utilities/app_util.dart';

import '../../../generated/locales.g.dart';
import '../../config/theme/app_color.dart';
import 'my_image.dart';

class MySearchTextField extends StatelessWidget {
  const MySearchTextField(
      {super.key,
      required this.height,
      required this.textEditingController,
      required this.margin,
      this.onCancelTap,
      required this.hintText,
      this.backgroundColor,
      this.onChanged,
      this.onSubmitted});

  final TextEditingController textEditingController;
  final Color? backgroundColor;
  final double height;
  final EdgeInsets margin;
  final String hintText;

  /// onCancelTap = null 说明没有 取消按钮，否则有取消按钮
  final VoidCallback? onCancelTap;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: margin,
      alignment: Alignment.center,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: backgroundColor ?? AppColor.colorBackgroundSecondary,
                borderRadius: BorderRadius.circular(100.r),
              ),
              alignment: Alignment.center,
              child: Row(
                children: [
                  12.horizontalSpace,
                  MyImage(
                    'assets/images/trade/search_icon.svg',
                    width: 16.w,
                    height: 16.w,
                    fit: BoxFit.contain,
                  ),
                  Expanded(
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      controller: textEditingController,
                      style: AppTextStyle.f_13_400,
                      cursorColor: AppColor.colorTextPrimary,
                      onSubmitted: (value) => onSubmitted?.call(value),
                      onChanged: (value) => onChanged?.call(value),
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.only(top: 0, bottom: 0, left: 8.w),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        disabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        hintText: hintText,
                        hintStyle: AppTextStyle.f_13_400.colorTextDisabled,
                        suffixIcon: textEditingController.text.isNotEmpty
                            ? IconButton(
                                icon: MyImage(
                                  'assets/images/trade/text_clear.svg',
                                  width: 16.w,
                                ),
                                onPressed: () {
                                  textEditingController.clear();
                                },
                              )
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (onCancelTap != null)
            InkWell(
              onTap: () {
                AppUtil.hideKeyboard(context);
                onCancelTap?.call();
              },
              child: Container(
                height: height,
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.public2.tr,
                  style: AppTextStyle.f_14_500.colorTextDescription,
                ),
              ).paddingOnly(left: 10.w),
            ),
        ],
      ),
    );
  }
}
