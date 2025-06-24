import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';

import '../basic/my_image.dart';

// 弹框顶部通用关闭
Widget dialogTopWidget(String title, String? content) {
  return SizedBox(
    height: 27.w,
    child: Stack(
      children: [
        Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: AppTextStyle.f_20_600,
            )),
        Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              child: MyImage(
                'default/close'.svgAssets(),
                fit: BoxFit.fill,
                width: 16.w,
                height: 16.w,
              ),
              onTap: () {
                Get.back();
              },
            ))
      ],
    ),
  );
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppTextStyle.f_20_600,
            ),
          ),
        ],
      ),
    ],
  );
}
