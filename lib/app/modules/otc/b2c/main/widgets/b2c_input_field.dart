import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utilities/text_input_formatter.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

class B2CInputField extends StatelessWidget {
  const B2CInputField(
      {super.key,
      required this.title,
      required this.textEditingController,
      this.subWidget,
      this.errorText,
      this.hintText,
      required this.precision,
      required this.focusNode,
      this.haveErrorStr = true,
      this.topRightView});

  final String title;
  final TextEditingController textEditingController;
  final Widget? subWidget;
  final String? errorText;
  final String? hintText;
  final int precision;
  final FocusNode focusNode;
  final bool haveErrorStr;
  final Widget? topRightView;

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter> list = [];
    list.add(allow(precision));
    list.add(FilteringTextInputFormatter.allow(RegExp("[0-9.]")));

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyle.f_12_600.color666666,
              ),
              topRightView ?? const SizedBox()
            ],
          ),
          10.verticalSpace,
          TextField(
            controller: textEditingController,
            inputFormatters: list,
            textInputAction: TextInputAction.done,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: hintText,
              suffixIcon: subWidget,
              contentPadding: EdgeInsets.all(16.w),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColor.colorECECEC,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColor.colorECECEC,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(
                  width: 1,
                  color: AppColor.color111111,
                ),
              ),
            ),
            style: AppTextStyle.f_16_500.color111111,
          ),
          if (haveErrorStr)
            Column(
              children: <Widget>[
                10.verticalSpace,
                Text(
                  errorText ?? '',
                  style: AppTextStyle.f_12_400.colorDanger,
                ),
              ],
            )
        ],
      ),
    );
  }
}
