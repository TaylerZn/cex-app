import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utilities/text_input_formatter.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

import '../../../config/theme/app_color.dart';

class TransactionInputWidget extends StatelessWidget {
  const TransactionInputWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixWidget,
    required this.keyboardType,
    this.width,
    this.height,
    this.enable = true,
    this.focusNode,
    this.maxLength,
    this.precision,
  });

  final TextEditingController controller;
  final String hintText;
  final Widget? suffixWidget;
  final TextInputType keyboardType;
  final double? width;
  final double? height;
  final bool? enable;
  final FocusNode? focusNode;
  final int? maxLength;

  /// 小数点后的位数
  final int? precision;

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> list = [];
    if (precision != null) {
      list.add(allow(precision ?? 0));
    } else {
      list.add(FilteringTextInputFormatter.allow(RegExp("[0-9.]")));
    }
    if (maxLength != null) {
      list.add(LengthLimitingTextInputFormatter(maxLength!));
    }
    return Container(
      width: width ?? 195.w,
      height: height ?? 40.h,
      decoration: ShapeDecoration(
        color: AppColor.colorBackgroundInput,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top:8.h),
              child: TextField(
                textInputAction: TextInputAction.done,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                cursorColor: AppColor.color111111,
                controller: controller,
                enabled: enable,
                focusNode: focusNode,
                inputFormatters: list,
                style: AppTextStyle.f_14_600.colorTextPrimary,
                onChanged: (value) {
                  // 如果已经包含小数点 . 就不能再输入小数点
                  if (value.contains('.')) {
                    if (value.lastIndexOf('.') != value.indexOf('.')) {
                      controller.text = value.substring(0, value.length - 1);
                      controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: controller.text.length),
                      );
                    }
                  }
                },
                decoration: InputDecoration(
                  alignLabelWithHint: false,
                  label: Text(
                    hintText,
                    style: AppTextStyle.f_14_400.copyWith(
                      color: AppColor.colorABABAB,
                    ),
                  ).marginOnly(bottom: 10.h),
                  labelStyle: AppTextStyle.f_14_600.copyWith(
                    color: AppColor.colorABABAB,
                  ),
                  isDense: true,
                  contentPadding: EdgeInsets.only(
                    left: 8.w,
                    top: 2.h,
                    bottom: 0,
                    right: 8.w,
                  ),
                  floatingLabelStyle: AppTextStyle.f_11_400
                      .copyWith(color: AppColor.color999999),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  disabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          if (suffixWidget != null) suffixWidget!,
        ],
      ),
    );
  }
}
