import 'dart:ui';

import 'package:flutter/material.dart' hide Image;

class ChartColors {
  List<Color> bgColor = [
    Colors.white,
    Colors.white
  ]; //[Color(0xff18191d), Color(0xff18191d)];

  Color kLineColor = const Color(0xff4C86CD);
  Color lineFillColor = const Color(0x554C86CD);
  Color lineFillInsideColor = const Color(0x00000000);
  Color ma5Color = const Color(0xffC9B885);
  Color ma10Color = const Color(0xff6CB0A6);
  Color ma30Color = const Color(0xff9979C6);
  Color upColor = const Color(0xff2EBD87);
  Color dnColor = const Color(0xffF54058);
  Color volColor = const Color(0xff4729AE);

  Color macdColor = const Color(0xff4729AE);
  Color difColor = const Color(0xffC9B885);
  Color deaColor = const Color(0xff6CB0A6);

  Color kColor = const Color(0xffC9B885);
  Color dColor = const Color(0xff6CB0A6);
  Color jColor = const Color(0xff9979C6);
  Color rsiColor = const Color(0xffC9B885);

  Color defaultTextColor = const Color(0xff999999);

  Color nowPriceUpColor = const Color(0xff2EBD87);
  Color nowPriceDnColor = const Color(0xffF54058);
  Color nowPriceTextColor = const Color(0xff111111);
  Color nowPriceLineColor = const Color(0xff999999);

  //深度颜色
  Color depthBuyColor = const Color(0xff2EBD87);
  Color depthSellColor = const Color(0xffF54058);

  //选中后显示值边框颜色
  Color selectBorderColor = const Color(0xffF9F9F9);

  //选中后显示值背景的填充颜色
  Color selectFillColor = const Color(0xFFF9F9F9);

  //分割线颜色
  Color gridColor = const Color(0xFFF5F5F5); // Color(0xff4c5c74);

  /// 选中提示框文字的颜色
  Color infoWindowNormalColor = const Color(0xff111111);
  Color infoWindowTitleColor = const Color(0xff111111);

  /// 选中提示框涨跌的颜色
  Color infoWindowUpColor = const Color(0xff2EBD87);
  Color infoWindowDnColor = const Color(0xffF54058);

  /// 十字线颜色
  Color hCrossColor = const Color(0xff8A8A8A);
  Color vCrossColor = const Color(0xff8A8A8A);
  Color crossTextColor = const Color(0xFFFFFFFF);

  //当前显示内最大和最小值的颜色
  Color maxColor = const Color(0xff666666);
  Color minColor = const Color(0xff666666);

  Color getMAColor(int index) {
    switch (index % 3) {
      case 1:
        return ma10Color;
      case 2:
        return ma30Color;
      default:
        return ma5Color;
    }
  }
}

class ChartStyle {
  double topPadding = 20.0;
  double kLineTopPadding = 15.0;
  double kLineBottomPadding = 22.0;

  double bottomPadding = 20.0;

  double childPadding = 20.0;

  //点与点的距离
  double pointWidth = 7.0;

  //蜡烛宽度
  double candleWidth = 5;

  //蜡烛中间线的宽度
  double candleLineWidth = 1;

  //vol柱子宽度
  double volWidth = 5;

  //macd柱子宽度
  double macdWidth = 5.0;

  //垂直交叉线宽度
  double vCrossWidth = 0.5;

  //水平交叉线宽度
  double hCrossWidth = 0.5;

  //现在价格的线条长度
  double nowPriceLineLength = 2;

  //现在价格的线条间隔
  double nowPriceLineSpan = 2;

  //现在价格的线条粗细
  double nowPriceLineWidth = 0.5;

  int gridRows = 4;

  int gridColumns = 5;

  //下方時間客製化
  List<String>? dateTimeFormat;

  /// 是否显示Logo
  bool showLogo = true;

  /// Logo
  static Image? logo;

  /// Logo大小
  var logoSize = const Size(79, 16);

  /// Logo外边距
  var logoPadding = const EdgeInsets.only(left: 6, bottom: 16);
}
