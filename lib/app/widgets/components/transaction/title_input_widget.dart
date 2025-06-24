import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';

import '../../../config/theme/app_color.dart';
import '../../../utils/utilities/text_input_formatter.dart';

class TitleInputWidget extends StatelessWidget {
  const TitleInputWidget(
      {super.key,
      required this.textEditingController,
      required this.title,
      required this.hintText,
      this.suffixWidget,
      this.width,
      this.enable = true,
      required this.focusNode,
      this.precision,
      this.maxLength});

  final TextEditingController textEditingController;
  final String title;
  final String hintText;
  final Widget? suffixWidget;
  final double? width;
  final bool enable;
  final int? precision;
  final int? maxLength;
  final FocusNode focusNode;

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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyle.f_16_600.color111111,
        ),
        10.verticalSpace,
        Container(
          height: 44.h,
          width: width,
          decoration: ShapeDecoration(
            color: enable ? AppColor.colorF4F4F4 : AppColor.colorD9D9D9,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          alignment: Alignment.center,
          child: enable
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        textInputAction: TextInputAction.done,
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        cursorColor: AppColor.color111111,
                        controller: textEditingController,
                        focusNode: focusNode,
                        inputFormatters: list,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColor.colorBlack,
                          fontWeight: FontWeight.w700,
                        ),
                        decoration: InputDecoration(
                          hintText: hintText,
                          hintStyle: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.colorABABAB,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.only(
                              left: 8.w, top: 20.h, bottom: 0, right: 8.w),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    if (suffixWidget != null) suffixWidget!,
                  ],
                )
              : Text(
                  hintText,
                  style: AppTextStyle.f_13_600.color999999,
                ),
        ),
      ],
    );
  }
}
