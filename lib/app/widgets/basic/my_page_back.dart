import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

class MyPageBackWidget extends StatelessWidget {
  const MyPageBackWidget({super.key, this.onTap, this.backColor});
  final VoidCallback? onTap;
  final Color? backColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap ?? () => Get.back(),
        child: Container(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 0.w, 8.h),
          child: Row(
            children: [
              MyImage(
                'default/page_back'.svgAssets(),
                width: 20.w,
                height: 20.w,
                color: backColor,
              )
            ],
          ),
        ));
  }
}
