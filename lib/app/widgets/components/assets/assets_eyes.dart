import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';

class AssetsEyes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssetsGetx>(builder: (assetsGetx) {
      return InkWell(
        onTap: () {
          assetsGetx.setEyesOpen();
        },
        child: MyImage(
          'default/${assetsGetx.isEyesOpen ? 'eyes_open' : 'eyes_close'}'
              .svgAssets(),
          width: 16.w,
          height: 16.w,
          color: AppColor.colorTextDescription,
        ),
      );
    });
  }
}
