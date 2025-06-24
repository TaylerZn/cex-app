import 'package:flutter/material.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';

class AppTextStyle {
  static TextStyle _textStyle({double size = 12, FontWeight weight = FontWeight.w300, double lineHeight = 1.5}) {
    return TextStyle(
      fontSize: size.sp,
      fontWeight: weight,
      height: lineHeight,
      color: AppColor.color111111,
      fontFamily: 'Ark Sans SC',
    );
  }

  ///////////////////////////////////旧的字体style，为了方便开发和UI对齐重新命名////////////////////////////////////////
  // static TextStyle h0_600 = _textStyle(size: 52, weight: FontWeight.w600);
  // static TextStyle h1_300 = _textStyle(size: 38);
  // static TextStyle h1_400 = _textStyle(size: 38, weight: FontWeight.w400);
  // static TextStyle h1_500 = _textStyle(size: 38, weight: FontWeight.w500);
  // static TextStyle h1_600 = _textStyle(size: 38, weight: FontWeight.w600);
  // static TextStyle h1_600_30 = _textStyle(size: 30, weight: FontWeight.w600);
  //
  // static TextStyle h3_300 = _textStyle(size: 28);
  // static TextStyle h3_400 = _textStyle(size: 28, weight: FontWeight.w400);
  // static TextStyle h3_500 = _textStyle(size: 28, weight: FontWeight.w500);
  // static TextStyle h3_600 = _textStyle(size: 28, weight: FontWeight.w600);
  //
  // static TextStyle h4_300 = _textStyle(size: 24);
  // static TextStyle h4_400 = _textStyle(size: 24, weight: FontWeight.w400);
  // static TextStyle h4_500 = _textStyle(size: 24, weight: FontWeight.w500);
  // static TextStyle h4_600 = _textStyle(size: 24, weight: FontWeight.w600);
  //
  // static TextStyle h5_300 = _textStyle(size: 20);
  // static TextStyle h5_400 = _textStyle(size: 20, weight: FontWeight.w400);
  static TextStyle h5_500 = _textStyle(size: 20, weight: FontWeight.w500);
  // static TextStyle h5_600 = _textStyle(size: 20, weight: FontWeight.w600);
  //
  // static TextStyle h6_300 = _textStyle(size: 18);
  // static TextStyle h6_400 = _textStyle(size: 18, weight: FontWeight.w400);
  // static TextStyle h6_500 = _textStyle(size: 18, weight: FontWeight.w500);
  // static TextStyle h6_600 = _textStyle(size: 18, weight: FontWeight.w600);
  //
  // static TextStyle h7_600 = _textStyle(size: 22, weight: FontWeight.w600);
  //
  // static TextStyle body_300 = _textStyle(size: 16);
  // static TextStyle body_400 = _textStyle(size: 16, weight: FontWeight.w400);
  // static TextStyle body_500 = _textStyle(size: 16, weight: FontWeight.w500);
  // static TextStyle body_600 = _textStyle(size: 16, weight: FontWeight.w600);
  //
  // static TextStyle body2_400 = _textStyle(size: 15, weight: FontWeight.w400);
  // static TextStyle body2_500 = _textStyle(size: 15, weight: FontWeight.w500);
  // static TextStyle body2_600 = _textStyle(size: 15, weight: FontWeight.w600);
  //
  // static TextStyle medium_300 = _textStyle(size: 14);
  // static TextStyle medium_400 = _textStyle(size: 14, weight: FontWeight.w400);
  // static TextStyle medium_500 = _textStyle(size: 14, weight: FontWeight.w500);
  // static TextStyle medium_600 = _textStyle(size: 14, weight: FontWeight.w600);
  //
  // static TextStyle medium2_300 = _textStyle(size: 13, lineHeight: 1.2);
  // static TextStyle medium2_400 =
  //     _textStyle(size: 13, weight: FontWeight.w400, lineHeight: 1.2);
  // static TextStyle medium2_500 =
  //     _textStyle(size: 13, weight: FontWeight.w500, lineHeight: 1.2);
  // static TextStyle medium2_600 =
  //     _textStyle(size: 13, weight: FontWeight.w600, lineHeight: 1.2);
  //
  // static TextStyle small_300 = _textStyle(size: 12, lineHeight: 1.2);
  // static TextStyle small_400 =
  //     _textStyle(size: 12, weight: FontWeight.w400, lineHeight: 1.2);
  static TextStyle small_400_150 = _textStyle(size: 12, weight: FontWeight.w400, lineHeight: 1.5);
  // static TextStyle small_500 =
  //     _textStyle(size: 12, weight: FontWeight.w500, lineHeight: 1.2);
  // static TextStyle small_600 =
  //     _textStyle(size: 12, weight: FontWeight.w600, lineHeight: 1.2);
  //
  // static TextStyle small2_300 = _textStyle(size: 11, lineHeight: 1.2);
  // static TextStyle small2_400 =
  //     _textStyle(size: 11, weight: FontWeight.w400, lineHeight: 1.2);
  // static TextStyle small2_500 =
  //     _textStyle(size: 11, weight: FontWeight.w500, lineHeight: 1.2);
  // static TextStyle small2_600 =
  //     _textStyle(size: 11, weight: FontWeight.w600, lineHeight: 1.2);
  //
  // static TextStyle small3_300 = _textStyle(size: 10, lineHeight: 1.2);
  static TextStyle small3_400 = _textStyle(size: 10, weight: FontWeight.w400, lineHeight: 1.2);
  static TextStyle small3_500 = _textStyle(size: 10, weight: FontWeight.w500, lineHeight: 1.2);
  // static TextStyle small3_600 =
  //     _textStyle(size: 10, weight: FontWeight.w600, lineHeight: 1.2);
  //
  // static TextStyle small4_300 = _textStyle(size: 9, lineHeight: 1.2);
  static TextStyle small4_400 = _textStyle(size: 9, weight: FontWeight.w400, lineHeight: 1.2);
  // static TextStyle small4_500 =
  //     _textStyle(size: 9, weight: FontWeight.w500, lineHeight: 1.2);
  // static TextStyle small4_600 =
  //     _textStyle(size: 9, weight: FontWeight.w600, lineHeight: 1.2);
  // static TextStyle small4_800 =
  //     _textStyle(size: 9, weight: FontWeight.w800, lineHeight: 1.2);
  // static TextStyle small5_600 =
  //     _textStyle(size: 8, weight: FontWeight.w600, lineHeight: 1.2);

  /////////////////////////////////新的使用/////////////////////////////////////////
  static TextStyle f_38_300 = _textStyle(size: 38);
  static TextStyle f_38_400 = _textStyle(size: 38, weight: FontWeight.w400);
  static TextStyle f_38_500 = _textStyle(size: 38, weight: FontWeight.w500);
  static TextStyle f_38_600 = _textStyle(size: 38, weight: FontWeight.w600);

  static TextStyle f_32_600 = _textStyle(size: 32, weight: FontWeight.w600);

  static TextStyle f_30_60 = _textStyle(size: 30, weight: FontWeight.w600);

  static TextStyle f_28_300 = _textStyle(size: 28);
  static TextStyle f_28_400 = _textStyle(size: 28, weight: FontWeight.w400);
  static TextStyle f_28_500 = _textStyle(size: 28, weight: FontWeight.w500);
  static TextStyle f_28_600 = _textStyle(size: 28, weight: FontWeight.w600);

  static TextStyle f_24_300 = _textStyle(size: 24);
  static TextStyle f_24_400 = _textStyle(size: 24, weight: FontWeight.w400);
  static TextStyle f_24_500 = _textStyle(size: 24, weight: FontWeight.w500);
  static TextStyle f_24_600 = _textStyle(size: 24, weight: FontWeight.w600);

  static TextStyle f_20_300 = _textStyle(size: 20);
  static TextStyle f_20_400 = _textStyle(size: 20, weight: FontWeight.w400);
  static TextStyle f_20_500 = _textStyle(size: 20, weight: FontWeight.w500);
  static TextStyle f_20_600 = _textStyle(size: 20, weight: FontWeight.w600);
  static TextStyle f_20_700 = _textStyle(size: 20, weight: FontWeight.w700);

  static TextStyle f_19_900 = _textStyle(size: 19, weight: FontWeight.w900);

  static TextStyle f_18_300 = _textStyle(size: 18);
  static TextStyle f_18_400 = _textStyle(size: 18, weight: FontWeight.w400);
  static TextStyle f_18_500 = _textStyle(size: 18, weight: FontWeight.w500);
  static TextStyle f_18_600 = _textStyle(size: 18, weight: FontWeight.w600);

  static TextStyle f_22_600 = _textStyle(size: 22, weight: FontWeight.w600);

  static TextStyle f_16_300 = _textStyle(size: 16);
  static TextStyle f_16_400 = _textStyle(size: 16, weight: FontWeight.w400);
  static TextStyle f_16_500 = _textStyle(size: 16, weight: FontWeight.w500);
  static TextStyle f_16_600 = _textStyle(size: 16, weight: FontWeight.w600);

  static TextStyle f_15_400 = _textStyle(size: 15, weight: FontWeight.w400);
  static TextStyle f_15_500 = _textStyle(size: 15, weight: FontWeight.w500);
  static TextStyle f_15_600 = _textStyle(size: 15, weight: FontWeight.w600);

  static TextStyle f_14_300 = _textStyle(size: 14);
  static TextStyle f_14_400 = _textStyle(size: 14, weight: FontWeight.w400);
  static TextStyle f_14_500 = _textStyle(size: 14, weight: FontWeight.w500);
  static TextStyle f_14_600 = _textStyle(size: 14, weight: FontWeight.w600);
  static TextStyle f_14_700 = _textStyle(size: 14, weight: FontWeight.w700);

  static TextStyle f_13_300 = _textStyle(size: 13, lineHeight: 1.2);
  static TextStyle f_13_400 = _textStyle(size: 13, weight: FontWeight.w400, lineHeight: 1.2);
  static TextStyle f_13_400_15 = _textStyle(size: 13, weight: FontWeight.w400, lineHeight: 1.5);
  static TextStyle f_13_500 = _textStyle(size: 13, weight: FontWeight.w500, lineHeight: 1.2);
  static TextStyle f_13_600 = _textStyle(size: 13, weight: FontWeight.w600, lineHeight: 1.2);

  static TextStyle f_12_300 = _textStyle(size: 12, lineHeight: 1.2);
  static TextStyle f_12_400 = _textStyle(size: 12, weight: FontWeight.w400, lineHeight: 1.2);
  static TextStyle f_12_400_15 = _textStyle(size: 12, weight: FontWeight.w400, lineHeight: 1.5);
  static TextStyle f_12_500 = _textStyle(size: 12, weight: FontWeight.w500, lineHeight: 1.2);
  static TextStyle f_12_600 = _textStyle(size: 12, weight: FontWeight.w600, lineHeight: 1.2);

  static TextStyle f_11_300 = _textStyle(size: 11, lineHeight: 1.2);
  static TextStyle f_11_400 = _textStyle(size: 11, weight: FontWeight.w400, lineHeight: 1.2);
  static TextStyle f_11_500 = _textStyle(size: 11, weight: FontWeight.w500, lineHeight: 1.2);
  static TextStyle f_11_600 = _textStyle(size: 11, weight: FontWeight.w600, lineHeight: 1.2);

  static TextStyle f_10_300 = _textStyle(size: 10, lineHeight: 1.2);
  static TextStyle f_10_400 = _textStyle(size: 10, weight: FontWeight.w400, lineHeight: 1.2);
  static TextStyle f_10_500 = _textStyle(size: 10, weight: FontWeight.w500, lineHeight: 1.2);
  static TextStyle f_10_600 = _textStyle(size: 10, weight: FontWeight.w600, lineHeight: 1.2);

  static TextStyle f_9_300 = _textStyle(size: 9, lineHeight: 1.2);
  static TextStyle f_9_400 = _textStyle(size: 9, weight: FontWeight.w400, lineHeight: 1.2);
  static TextStyle f_9_400_15 = _textStyle(size: 9, weight: FontWeight.w400, lineHeight: 1.5);
  static TextStyle f_9_500 = _textStyle(size: 9, weight: FontWeight.w500, lineHeight: 1.2);
  static TextStyle f_9_600 = _textStyle(size: 9, weight: FontWeight.w600, lineHeight: 1.2);
  static TextStyle f_9_800 = _textStyle(size: 9, weight: FontWeight.w800, lineHeight: 1.2);
  static TextStyle f_8_600 = _textStyle(size: 8, weight: FontWeight.w600, lineHeight: 1.2);
  static TextStyle f_8_500 = _textStyle(size: 8, weight: FontWeight.w500, lineHeight: 1.2);
  static TextStyle f_8_400 = _textStyle(size: 8, weight: FontWeight.w400, lineHeight: 1.2);
  static TextStyle f_6_400 = _textStyle(size: 6, weight: FontWeight.w400, lineHeight: 1.2);
}

extension TextColor on TextStyle {
  // 主色
  TextStyle get mainColor => copyWith(color: AppColor.mainColor);
  // 涨幅颜色
  TextStyle get upColor => copyWith(color: AppColor.upColor);
  // 跌幅颜色
  TextStyle get downColor => copyWith(color: AppColor.downColor);

  TextStyle get transparent => copyWith(color: AppColor.transparent);

  // @或#颜色
  TextStyle get tradingYel => copyWith(color: AppColor.tradingYel);

  TextStyle get colorTextError => copyWith(color: AppColor.colorTextError);

  // 文字颜色
  TextStyle get color111111 => copyWith(color: AppColor.color111111);
  TextStyle get color333333 => copyWith(color: AppColor.color333333);
  TextStyle get color4D4D4D => copyWith(color: AppColor.color4D4D4D);
  TextStyle get color4c4c4c => copyWith(color: AppColor.color4c4c4c);
  TextStyle get color666666 => copyWith(color: AppColor.color666666);
  TextStyle get color999999 => copyWith(color: AppColor.color999999);
  TextStyle get colorFFFFFF => copyWith(color: AppColor.colorFFFFFF);
  TextStyle get colorABABAB => copyWith(color: AppColor.colorABABAB);
  TextStyle get colorEEEEEE => copyWith(color: AppColor.colorEEEEEE);
  TextStyle get colorEDEDED => copyWith(color: AppColor.colorEDEDED);
  TextStyle get colorCCCCCC => copyWith(color: AppColor.colorCCCCCC);
  TextStyle get colorBBBBBB => copyWith(color: AppColor.colorBBBBBB);
  TextStyle get colorF1F1F1 => copyWith(color: AppColor.colorF1F1F1);
  TextStyle get colorF2F2F2 => copyWith(color: AppColor.colorF2F2F2);
  TextStyle get colorF4F4F4 => copyWith(color: AppColor.colorF4F4F4);
  TextStyle get colorF5F5F5 => copyWith(color: AppColor.colorF5F5F5);
  TextStyle get colorA3A3A3 => copyWith(color: AppColor.colorA3A3A3);
  TextStyle get colorDCDCDC => copyWith(color: AppColor.colorDCDCDC);
  TextStyle get color0075FF => copyWith(color: AppColor.color0075FF);
  TextStyle get colorDDDDDD => copyWith(color: AppColor.colorDDDDDD);
  TextStyle get colorDBDBDB => copyWith(color: AppColor.colorDBDBDB);
  TextStyle get colorD9D9D9 => copyWith(color: AppColor.colorD9D9D9);
  TextStyle get colorECECEC => copyWith(color: AppColor.colorECECEC);
  TextStyle get color313131 => copyWith(color: AppColor.color313131);
  TextStyle get colorEA1F1F => copyWith(color: AppColor.colorEA1F1F);
  TextStyle get color60ffff => copyWith(color: AppColor.color60ffff);
  TextStyle get color7A7A7A => copyWith(color: AppColor.color7A7A7A);
  TextStyle get colorE64F44 => copyWith(color: AppColor.colorE64F44);
  TextStyle get colorFFD429 => copyWith(color: AppColor.colorFFD429);
  TextStyle get colorF3F3F3 => copyWith(color: AppColor.colorF3F3F3);
  TextStyle get color7E7E7E => copyWith(color: AppColor.color7E7E7E);
  TextStyle get colorF53F57 => copyWith(color: AppColor.colorF53F57);
  TextStyle get color0C0D0F => copyWith(color: AppColor.color0C0D0F);
  TextStyle get colorF7F7F7 => copyWith(color: AppColor.colorF7F7F7);
  TextStyle get color2EBD87 => copyWith(color: AppColor.color2EBD87);
  TextStyle get colorF6465D => copyWith(color: AppColor.colorF6465D);
  TextStyle get color8E8E92 => copyWith(color: AppColor.color8E8E92);
  TextStyle get colorF3F3F5 => copyWith(color: AppColor.colorF3F3F5);
  TextStyle get colorD29102 => copyWith(color: AppColor.colorD29102);

  TextStyle get colorSuccess => copyWith(color: AppColor.colorSuccess);
  TextStyle get colorDanger => copyWith(color: AppColor.colorDanger);

  TextStyle get colorWhite => copyWith(color: AppColor.colorWhite);
  TextStyle get colorBlack => copyWith(color: AppColor.colorBlack);

  ////////////////////////// 新的色值配置 开始 /////////////////////////////
  TextStyle get colorTips => copyWith(color: AppColor.colorTipsColor);
  TextStyle get colorTextDescription => copyWith(color: AppColor.colorTextDescription);
  TextStyle get colorTextPrimary => copyWith(color: AppColor.colorTextPrimary);
  TextStyle get colorTextSecondary => copyWith(color: AppColor.colorTextSecondary);
  TextStyle get colorTextTips => copyWith(color: AppColor.colorTextTips);
  TextStyle get colorTextDisabled => copyWith(color: AppColor.colorTextDisabled);
  TextStyle get colorAlwaysWhite => copyWith(color: AppColor.colorAlwaysWhite);
  TextStyle get colorAlwaysBlack => copyWith(color: AppColor.colorAlwaysBlack);
  TextStyle get colorFunctionBuy => copyWith(color: AppColor.colorFunctionBuy);
  TextStyle get colorFunctionSell => copyWith(color: AppColor.colorFunctionSell);
  TextStyle get colorTextTertiary => copyWith(color: AppColor.colorTextTertiary);
  TextStyle get colorTextInversePrimary => copyWith(color: AppColor.colorTextInversePrimary);
  TextStyle get colorFunctionTradingYel => copyWith(color: AppColor.colorTextTertiary);

  ////////////////////////// 新的色值配置 结束 /////////////////////////////

  /// 主题配置色 暂时用不上（没有主题切换）
  TextStyle get colorTextPrimaryLight => copyWith(color: AppColor.colorTextPrimaryLight);
  TextStyle get colorTextSecondaryLight => copyWith(color: AppColor.colorTextSecondaryLight);
  TextStyle get bgColorLight => copyWith(color: AppColor.bgColorLight);
  TextStyle get cardBgColorLight => copyWith(color: AppColor.cardBgColorLight);

  TextStyle get colorTextPrimaryDark => copyWith(color: AppColor.colorTextPrimaryDark);
  TextStyle get colorTextSecondaryDark => copyWith(color: AppColor.colorTextSecondaryDark);
  TextStyle get bgColorDark => copyWith(color: AppColor.bgColorDark);
  TextStyle get cardBgColorDark => copyWith(color: AppColor.cardBgColorDark);

  // 分割线
  TextStyle get dividerColorLight => copyWith(color: AppColor.dividerColorLight);
  TextStyle get dividerColorDark => copyWith(color: AppColor.dividerColorDark);
  TextStyle get ellipsis => copyWith(overflow: TextOverflow.ellipsis);
}
