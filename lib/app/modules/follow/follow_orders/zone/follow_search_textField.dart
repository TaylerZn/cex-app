import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

class SearchTextField extends StatefulWidget {
  const SearchTextField(
      {super.key,
      this.havePrefixIcon = true,
      this.haveSuffixIcon = true,
      this.hintText = '',
      this.height = 44,
      this.fontSize = 16,
      this.keyboardType,
      this.inputFormatters,
      this.enabled = true,
      this.haveTopPadding = true,
      this.haveBottomPadding = false,
      this.fillColor = AppColor.colorF4F4F4,
      this.controller,
      this.onChanged,
      this.autofocus = false,
      this.onSubmitted});
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

  final bool autofocus;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
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
        // onChanged: debounce((value) {
        //   widget.onChanged?.call(value);
        // }),
        // onChanged: debounce((value) {
        //   widget.onChanged?.call(value);
        // }),
        onChanged: (value) => widget.onChanged?.call(value),
        onSubmitted: (value) => widget.onSubmitted?.call(value),
        style: AppTextStyle.f_13_500,
        decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: AppTextStyle.f_13_400.colorABABAB,
            prefixIcon: widget.havePrefixIcon
                ? SizedBox(
                    width: 42.w,
                    child: Row(
                      children: [
                        16.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MyImage(
                              'assets/search'.svgAssets(),
                              width: 16.w,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : null,
            suffixIcon: widget.enabled && widget.haveSuffixIcon && _showSuffixIcon
                ? GestureDetector(
                    onTap: () {
                      _controller.clear();
                      setState(() {
                        _showSuffixIcon = false;
                      });
                    },
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyImage(
                            'trade/search_right_suffix'.svgAssets(),
                          ),
                        ]),
                  )
                : null,
            // filled: true,
            // fillColor: widget.fillColor,
            border: InputBorder.none,
            contentPadding: EdgeInsets.fromLTRB(0, widget.haveTopPadding ? (widget.height.h - widget.fontSize) * 0.4 : 0, 0,
                widget.haveTopPadding ? (widget.height.h - widget.fontSize) * 0.5 : 0),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide.none,
            )),
        cursorColor: AppColor.color111111,
        textAlignVertical: TextAlignVertical.center,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
      ),
    );
  }
}
