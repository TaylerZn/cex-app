import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

class AssetsFundsSearchTextField extends StatefulWidget {
  const AssetsFundsSearchTextField({
    super.key,
    this.havePrefixIcon = true,
    this.haveSuffixIcon = true,
    this.hintText = '',
    this.height = 32,
    this.fontSize = 15,
    this.keyboardType,
    this.inputFormatters,
    this.enabled = true,
    this.haveTopPadding = true,
    this.haveBottomPadding = false,
    this.fillColor = AppColor.colorF4F4F4,
    this.controller,
    this.onChanged,
    this.onFocusChanged,
    this.autofocus = false,
    this.onSubmitted,
  });

  final bool enabled;

  final bool havePrefixIcon;
  final bool haveSuffixIcon;
  final bool haveTopPadding;
  final bool haveBottomPadding;
  final Color fillColor;
  final String hintText;
  final double height;
  final double fontSize;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final Function(String)? onFocusChanged;
  final bool autofocus;

  @override
  State<AssetsFundsSearchTextField> createState() =>
      _AssetsFundsSearchTextFieldState();
}

class _AssetsFundsSearchTextFieldState
    extends State<AssetsFundsSearchTextField> {
  late TextEditingController _controller;
  bool _showSuffixIcon = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_checkText);
  }

  void _checkText() {
    setState(() {
      _showSuffixIcon = _controller.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height.h,
      child: TextField(
        autofocus: widget.autofocus,
        enabled: widget.enabled,
        controller: _controller,
        onChanged: (value) => widget.onChanged?.call(value),
        onSubmitted: (value) => widget.onSubmitted?.call(value),
        style: TextStyle(
            color: AppColor.color111111,
            fontSize: widget.fontSize,
            fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppTextStyle.f_15_500.colorBBBBBB,
          suffixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            child: MyImage(
              'assets/assets_search'.svgAssets(),
            ),
          ),
          filled: true,
          fillColor: widget.fillColor,
          // fillColor: Colors.red,
          border: InputBorder.none,
          contentPadding: EdgeInsets.fromLTRB(
              10,
              widget.haveTopPadding
                  ? (widget.height.h - widget.fontSize) * 0.4
                  : 0,
              0,
              widget.haveTopPadding
                  ? (widget.height.h - widget.fontSize) * 0.5
                  : 0),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
        cursorColor: AppColor.color111111,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
      ),
    );
  }
}
