import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/third_login_utils.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class MoreLogin extends StatefulWidget {
  const MoreLogin({super.key});

  @override
  State<MoreLogin> createState() => _MoreLoginState();
}

class _MoreLoginState extends State<MoreLogin> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 24.w, horizontal: 16.w),
          child: Row(
            children: [
              Expanded(
                  child: Container(
                height: 1,
                color: AppColor.colorEEEEEE,
              )),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Text(
                  LocaleKeys.user330.tr,
                  style: AppTextStyle.f_11_400.color999999,
                ),
              ),
              Expanded(
                  child: Container(
                height: 1.w,
                color: AppColor.colorECECEC,
              ))
            ],
          ),
        ),
        buildMoreLogin(),
      ],
    );
  }

  Widget buildMoreLogin() {
    List moreList = [
      {"index": 1, "icon": "default/third_apple", "title": "APPLE_LOGIN"},
      {"index": 2, "icon": "default/third_google", "title": "GOOGLE_LOGIN"},
      // {"index": 3, "icon": "default/third_tg", "title": "TELEGRAM_LOGIN"},
    ]..removeWhere((element) => element['index'] == 1 && Platform.isAndroid);

    return Wrap(
      spacing: 47.5.w,
      children: moreList.asMap().keys.map((e) {
        var item = moreList[e];
        return MyButton(
          width: 40.w,
          height: 40.w,
          backgroundColor: AppColor.colorFFFFFF,
          border: Border.all(width: 1.w, color: AppColor.colorF5F5F5),
          child: MyImage(
            '${item['icon']}'.svgAssets(),
            fit: BoxFit.fill,
            width: 20.w,
            height: 20.w,
          ),
          onTap: () {
            ThirdLoginUtils.thirdLogin(item['index']);
          },
        );
      }).toList(),
    );
  }
}
