// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

class MyButton extends StatelessWidget {
  Widget? child;
  double? width;
  double? minWidth;
  double? height;
  EdgeInsetsGeometry? padding;
  BorderRadius? borderRadius;
  Gradient? gradient;
  BoxBorder? border;
  Color? color;
  TextStyle? textStyle;
  Color? backgroundColor;
  Color? splashColor;
  BoxShadow? boxShadow;
  GestureTapCallback? onTap;
  bool goIcon;
  TextAlign? textAlign;
  Color? goIconColor;

  MyButton({
    super.key,
    this.child,
    BorderRadius? borderRadius,
    String? text,
    this.width,
    this.minWidth,
    this.height,
    this.gradient,
    this.border,
    this.textStyle,
    this.color = AppColor.colorWhite,
    this.splashColor = Colors.white54,
    this.boxShadow,
    this.backgroundColor,
    this.padding,
    this.onTap,
    this.textAlign,
    this.goIcon = false,
    this.goIconColor = AppColor.colorWhite,
  }) {
    if (text != null) {
      child = Text(text,
          textAlign: textAlign,
          style: textStyle?.copyWith(
                color: color,
              ) ??
              AppTextStyle.f_16_600.copyWith(
                color: color,
              ));
    } else {
      child = child;
    }
    this.borderRadius =
        borderRadius ?? const BorderRadius.all(Radius.circular(40));
  }

  /// 工厂方法：背景绿色 标题黑色
  factory MyButton.mainBg({
    String? text,
    double? width,
    double? minWidth,
    double? height,
    var child,
    EdgeInsetsGeometry? padding,
    BoxBorder? border,
    BorderRadius? borderRadius,
    Gradient? gradient,
    Color? color,
    TextStyle? textStyle,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
    Color? splashColor,
    BoxShadow? boxShadow,
    bool goIcon = false,
    Color? goIconColor = Colors.white,
    GestureTapCallback? onTap,
  }) {
    return MyButton(
      text: text,
      width: width,
      minWidth: minWidth,
      height: height,
      padding: padding,
      border: border,
      borderRadius: borderRadius,
      gradient: gradient,
      textStyle: textStyle,
      splashColor: splashColor,
      boxShadow: boxShadow,
      goIcon: goIcon,
      goIconColor: goIconColor,
      onTap: onTap,
      color: AppColor.colorBlack,
      backgroundColor: AppColor.mainColor,
    );
  }

  // /// 工厂方法：背景黑色 标题白色
  factory MyButton.borderWhiteBg({
    String? text,
    double? width,
    double? minWidth,
    double? height,
    var child,
    EdgeInsetsGeometry? padding,
    BoxBorder? border,
    BorderRadius? borderRadius,
    Gradient? gradient,
    Color? color,
    TextStyle? textStyle,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
    Color? splashColor,
    BoxShadow? boxShadow,
    bool goIcon = false,
    Color? goIconColor = Colors.white,
    GestureTapCallback? onTap,
  }) {
    return MyButton(
      text: text,
      width: width,
      minWidth: minWidth,
      height: height,
      padding: padding,
      border: border ?? Border.all(width: 1, color: AppColor.colorECECEC),
      borderRadius: borderRadius,
      gradient: gradient,
      textStyle: textStyle,
      splashColor: splashColor,
      boxShadow: boxShadow,
      goIcon: goIcon,
      goIconColor: goIconColor,
      onTap: onTap,
      color: AppColor.colorBlack,
      backgroundColor: AppColor.colorWhite,
    );
  }

  /// 工厂方法：背景灰色 标题白色 goIcon
  factory MyButton.greyBgGoIcon({
    String? text,
    double? width,
    double? minWidth,
    double? height,
    var child,
    EdgeInsetsGeometry? padding,
    BoxBorder? border,
    BorderRadius? borderRadius,
    Gradient? gradient,
    Color? color,
    TextStyle? textStyle,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
    Color? splashColor,
    BoxShadow? boxShadow,
    bool goIcon = false,
    Color? goIconColor = Colors.white,
    GestureTapCallback? onTap,
  }) {
    return MyButton(
      text: text,
      width: width,
      minWidth: minWidth,
      height: height,
      padding: padding,
      border: border,
      borderRadius: borderRadius,
      gradient: gradient,
      textStyle: textStyle,
      splashColor: splashColor,
      boxShadow: boxShadow,
      goIconColor: goIconColor,
      onTap: onTap,
      color: Colors.white,
      backgroundColor: AppColor.colorCCCCCC,
      goIcon: true,
    );
  }

  /// 工厂方法：背景主色 标题黑色 goIcon
  factory MyButton.greenBgGoIcon({
    String? text,
    double? width,
    double? minWidth,
    double? height,
    var child,
    EdgeInsetsGeometry? padding,
    BoxBorder? border,
    BorderRadius? borderRadius,
    Gradient? gradient,
    Color? color,
    TextStyle? textStyle,
    double fontSize = 16,
    FontWeight fontWeight = FontWeight.w600,
    Color? splashColor,
    BoxShadow? boxShadow,
    bool goIcon = false,
    Color? goIconColor = Colors.white,
    GestureTapCallback? onTap,
  }) {
    return MyButton(
      text: text,
      width: width,
      minWidth: minWidth,
      height: height,
      padding: padding,
      border: border,
      borderRadius: borderRadius,
      gradient: gradient,
      textStyle: textStyle,
      splashColor: splashColor,
      boxShadow: boxShadow,
      onTap: onTap,
      color: Colors.black,
      backgroundColor: AppColor.mainColor,
      goIconColor: AppColor.color111111,
      goIcon: true,
    );
  }

  factory MyButton.outline({
    required String text,
    double? width,
    double? height,
    EdgeInsetsGeometry? padding,
    BoxBorder? border,
    Color? color,
    TextStyle? textStyle,
    Color? backgroundColor,
    required GestureTapCallback onTap,
  }) {
    return MyButton(
      height: height ?? 48.h,
      width: width,
      text: text,
      backgroundColor: backgroundColor ?? AppColor.colorAlwaysWhite,
      color: AppColor.colorTextPrimary,
      textStyle: textStyle,
      border: Border.all(
        color: AppColor.colorBorderStrong,
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    Gradient? gradient;
    if (this.gradient != null) {
      gradient = this.gradient;
    } else if (backgroundColor != null) {
      backgroundColor = backgroundColor;
    }
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: throttle(() async {
          if (onTap != null) {
            onTap!();
          }
        }),
        splashColor: splashColor,
        highlightColor: Colors.transparent,
        borderRadius: borderRadius,
        child: Container(
          width: width,
          height: height,
          padding: padding,
          alignment: Alignment.center,
          constraints: minWidth != null
              ? BoxConstraints(minWidth: minWidth as double)
              : null,
          decoration: BoxDecoration(
            gradient: gradient,
            color: backgroundColor ?? AppColor.color111111,
            borderRadius: borderRadius,
            border: border,
            boxShadow: boxShadow != null
                ? [
                    const BoxShadow(
                      offset: Offset(0, 8),
                      blurRadius: 16, //阴影范围
                      spreadRadius: 0, //阴影浓度
                      color: Color(0x04000000), //阴影颜色
                    )
                  ]
                : [],
          ),
          child: goIcon
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Row(
                    children: [
                      Expanded(child: child ?? const SizedBox()),
                      MyImage('default/go_arrow'.svgAssets(),
                          width: 24.w, color: goIconColor)
                    ],
                  ))
              : child,
        ),
      ),
    );
  }
}
