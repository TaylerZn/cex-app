import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class MyExtendedTextField extends StatelessWidget {
  final Function(String)? onChanged;
  final Function(String)? onSubmit;
  final String? hintText;
  final String? value;
  int? maxLength;
  MyExtendedTextField(
      {this.hintText,
      this.onChanged,
      this.value,
      this.onSubmit,
      this.maxLength = 200});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6.r)),
          border: Border.all(color: AppColor.colorF5F5F5)),
      height: 100.h,
      child: ExtendedTextField(
        maxLength: maxLength,
        controller: TextEditingController(text: value),
        scrollPadding: EdgeInsets.all(0),
        autofocus: false,
        onChanged: (text) {
          onChanged?.call(text);
        },
        textInputAction: TextInputAction.send,
        // focusNode: controller.focus,
        onSubmitted: (String val) async {
          onSubmit?.call(val);
          //   controller.onSubmitTap(data, level, index);
        },
        maxLines: null,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText ?? LocaleKeys.c2c43.tr,
          hintStyle: AppTextStyle.f_14_400.colorABABAB.copyWith(height: 1),
        ),
      ),
    );
  }
}
