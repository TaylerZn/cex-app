import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';

import 'app_color.dart';

class AppTheme {
  static ThemeData createTheme({
    required Brightness brightness,
    required Color background,
    required Color primaryTextColor,
    required Color labelTextColor,
    required Color primaryColor,
    required Color cardBgColor,
    required Color divider,
  }) {
    final baseTextTheme = brightness == Brightness.dark
        ? Typography.blackMountainView
        : Typography.whiteMountainView;

    return ThemeData(
      fontFamily: 'Ark Sans SC',
      useMaterial3: false,
      brightness: brightness,
      canvasColor: background,
      cardColor: background,
      dividerColor: divider,
      primarySwatch: AppColor.createMaterialColor(primaryColor),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      dividerTheme: DividerThemeData(
        color: divider,
        space: 1,
        thickness: 1,
      ),
      scrollbarTheme: ScrollbarThemeData(
        radius: const Radius.circular(10),

        /// 滚动条的常亮
        thumbVisibility: MaterialStateProperty.all<bool>(true),
        thumbColor: MaterialStateProperty.all(Colors.white.withOpacity(0.08)),
        trackColor: MaterialStateProperty.all(Colors.white.withOpacity(0.08)),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.transparent,
      ),
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: AppColor.createMaterialColor(primaryColor),
        // primaryColorDark: primaryColor,
        accentColor: primaryColor,
        backgroundColor: background,
        brightness: brightness,
      ),
      tabBarTheme: TabBarTheme(
        /// 点击 hover颜色
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        dividerColor: Colors.transparent,
        dividerHeight: 0,
        labelColor: primaryTextColor,
        unselectedLabelColor: labelTextColor,
        tabAlignment: TabAlignment.start,
        labelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        indicatorSize: TabBarIndicatorSize.label,
        unselectedLabelStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
        ),
        indicator: UnderlineTabIndicator(
          borderSide: BorderSide(
            color: const Color(0xFF3E65FF),
            width: 3.h,
          ),
          insets: EdgeInsets.only(bottom: 4.h),
        ),
      ),
      splashFactory: NoSplash.splashFactory,
      primaryColor: primaryColor,
      appBarTheme: AppBarTheme(
        iconTheme: const IconThemeData(),
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        color: background,
        elevation: 0,
        titleTextStyle: AppTextStyle.f_16_500,
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF546371),
        size: 24.0,
      ),
      scaffoldBackgroundColor: background,
      drawerTheme: DrawerThemeData(
        elevation: 0,
        backgroundColor: background,
        width: 0.7.sw,
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        border: const OutlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        disabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide.none),
        labelStyle: AppTextStyle.f_16_500.copyWith(color: labelTextColor),
        hintStyle: AppTextStyle.f_16_500.copyWith(color: labelTextColor),
      ),
      cardTheme: CardTheme(
        color: cardBgColor,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 0,
      ),
      textTheme: TextTheme(
        bodyLarge: baseTextTheme.bodyLarge?.copyWith(
          fontSize: 34.sp,
          color: primaryTextColor,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  static ThemeData get light => createTheme(
        brightness: Brightness.light,
        background: AppColor.colorWhite,
        primaryTextColor: AppColor.colorTextPrimaryLight,
        primaryColor: AppColor.colorTextPrimaryLight,
        cardBgColor: AppColor.cardBgColorLight,
        divider: AppColor.dividerColorLight,
        labelTextColor: AppColor.colorTextSecondaryLight,
      );

  static ThemeData get dark => createTheme(
        brightness: Brightness.dark,
        background: AppColor.bgColorDark,
        primaryTextColor: AppColor.colorTextPrimaryDark,
        primaryColor: AppColor.colorWhite,
        cardBgColor: AppColor.cardBgColorDark,
        divider: AppColor.dividerColorDark,
        labelTextColor: AppColor.colorTextPrimaryDark,
      );
}
