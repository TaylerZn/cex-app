import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';

class AssetInputWidget extends StatefulWidget {
  final TextEditingController controller;
  final String? hint;
  final Widget? child;
  final Border? border;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  const AssetInputWidget(
      {super.key,
      required this.controller,
      this.inputFormatters,
      this.maxLines = 1,
      this.border,
      this.hint,
      this.child});

  @override
  State<AssetInputWidget> createState() => _AssetInputWidgetState();
}

class _AssetInputWidgetState extends State<AssetInputWidget> {
  FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 48.w),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8.r)),
          color: AppColor.colorBackgroundInput,
          border: widget.border ??
              Border.all(
                  color: focusNode.hasFocus
                      ? AppColor.color111111
                      : Colors.transparent)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: ExtendedTextField(
            focusNode: focusNode,
            onChanged: (value) {
              setState(() {});
            },
            inputFormatters: widget.inputFormatters,
            maxLines: widget.maxLines,
            // 焦点控制
            controller: widget.controller,
            // 与输入框交互控制器
            //装饰
            decoration: InputDecoration(
              border: InputBorder.none,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide.none,
              ),
              hintText: widget.hint,
              hintStyle: AppTextStyle.f_14_500.colorTextDisabled,
              contentPadding: const EdgeInsets.only(left: 0.0),
            ),
            style: AppTextStyle.f_14_500.color111111,
            // 键盘动作右下角图标
          )),
          widget.child != null
              ? Container(
                  margin: EdgeInsets.only(left: 8.w), child: widget.child)
              : SizedBox()
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(covariant AssetInputWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    if (oldWidget.border != widget.border) {
      setState(() {});
    }
  }
}
