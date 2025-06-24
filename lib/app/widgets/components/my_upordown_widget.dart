import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/number_util.dart';

//涨跌颜色widget
class MyUpOrDownWidget extends StatelessWidget {
  dynamic number;
  Color? color;
  double? fontSize;
  FontWeight fontWeight;
  bool isPercent; //是否为百分比
  bool isUsdt; //后边是否跟usdt

  MyUpOrDownWidget(
      {super.key,
      required this.number,
      this.fontSize,
      this.color,
      this.fontWeight = FontWeight.w600,
      this.isPercent = false,
      this.isUsdt = false}) {
    if (number == null || number == '') {
      number = 0.00;
    }
    if ((number is num) != true) number = double.parse(number);
    if (number >= 0) {
      color = AppColor.upColor;
    } else {
      color = AppColor.downColor;
    }
    if (isPercent) {
      number = number * 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      ('${number >= 0 ? '+' : ''}${NumberUtil.mConvert(number)}${isPercent ? '%' : ''}${isUsdt ? ' USDT' : ''}')
          .stringSplit(),
      style: TextStyle(
          fontSize: fontSize ?? 12.sp, color: color, fontWeight: fontWeight),
      overflow: TextOverflow.ellipsis,
    );
  }
}
