import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class NoDataClass {
  static const String noData = 'default/no_data';
  static const String noNews = 'default/no_news';
  static const String noComment = 'default/no_comment';
}

Widget noDataWidget(context,
    {double? wigetHeight,
    String? text,
    double? iconSize,
    String noDateIcon = NoDataClass.noData,
    bool svg = false}) {
  return Center(
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: wigetHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MyImage(
                svg ? noDateIcon.svgAssets() : noDateIcon.pngAssets(),
                width: iconSize ?? 102.w,
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 18.w, 0, 0),
                child: Text(text ?? LocaleKeys.public32.tr,
                    style: AppTextStyle.f_12_400.color999999),
              )
            ],
          )));
}
