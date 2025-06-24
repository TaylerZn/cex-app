import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';

class MyTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefix;
  final Color? color;

  final TextStyle? style;
  final String? title;
  final String? hintText;
  final String? errorText;
  final Color? backGroundColor;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final TextStyle? hintStyle;
  final TextAlign textAlign;
  final bool obscureText;
  final int? maxLength;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final bool isTopText;
  final bool getCode;
  final bool readOnly;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final double? height;

  MyTextFieldWidget(
      {super.key,
      this.controller,
      this.hintText,
      this.errorText,
      this.suffixIcon,
      this.prefix,
      this.color = Colors.white,
      this.style,
      this.title,
      this.backGroundColor,
      this.enabledBorderColor,
      this.focusedBorderColor,
      this.hintStyle,
      this.textAlign = TextAlign.left,
      this.obscureText = false,
      this.maxLength,
      this.keyboardType = TextInputType.text,
      this.focusNode,
      this.inputFormatters,
      this.isTopText = true,
      this.getCode = false,
      this.readOnly = false,
      this.onChanged,
      this.onTap,
      this.height}) {}

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      title != null
          ? Column(
              children: [
                Text('$title', style: AppTextStyle.f_11_400.color666666),
                8.verticalSpace,
              ],
            )
          : const SizedBox(),
      Container(
          height: height ?? 50.h,
          decoration: BoxDecoration(
              color: backGroundColor ?? AppColor.colorWhite.withOpacity(0),
              borderRadius: BorderRadius.circular(6.r)),
          alignment: Alignment.center,
          child: TextField(
            onTap: onTap,
            focusNode: focusNode,
            inputFormatters: inputFormatters ?? [],
            maxLength: maxLength,
            textAlign: textAlign,
            cursorColor: AppColor.color111111,
            controller: controller,
            style: style ?? AppTextStyle.f_14_600.copyWith(height: 1.2),
            obscureText: obscureText,
            onChanged: onChanged,
            readOnly: readOnly,
            keyboardType: keyboardType,
            obscuringCharacter: '*',
            decoration: InputDecoration(
              prefix: prefix,
              suffixIcon: suffixIcon,
              labelText: isTopText ? hintText : null,
              labelStyle: isTopText ? hintStyle : null,
              hintText: isTopText ? null : hintText,
              hintStyle: isTopText ? null : hintStyle,
              floatingLabelStyle: AppTextStyle.f_15_400.color666666,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 1,
                      color: enabledBorderColor ?? AppColor.colorECECEC)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: focusedBorderColor ?? AppColor.color111111)),
            ),
          ))
    ]);
  }
}
