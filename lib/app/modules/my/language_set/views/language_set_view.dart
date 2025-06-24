import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../models/contract/res/public_info.dart';
import '../../../../widgets/basic/my_image.dart';
import '../controllers/language_set_controller.dart';

class LanguageSetView extends GetView<LanguageSetController> {
  const LanguageSetView({super.key});

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('LanguageSetView'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction == 1.0) {
          controller.checkLangInfoIfIsEmpty();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          leading: const MyPageBackWidget(),
          title: Text(LocaleKeys.user192.tr),
          centerTitle: true,
        ),
        body: Obx(() {
          return ListView.builder(
            itemCount: controller.langInfoList.length,
            itemBuilder: (BuildContext context, int index) {
              return _item(controller.langInfoList[index]);
            },
          );
        }),
      ),
    );
  }

  Widget _item(LangInfo langInfo) {
    return Obx(() {
      return InkWell(
        splashColor: AppColor.colorF5F5F5.withOpacity(0.2),
        onTap: () {
          controller.changeLange(langInfo,true);
        },
        child: Container(
          height: 60.h,
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(langInfo.langName,
                      style: AppTextStyle.f_15_500.copyWith(
                          color: AppColor.color111111,
                          fontFamily: 'PingFang SC',
                          fontWeight: FontWeight.w600)),
                  const Spacer(),
                  if (controller.currentLang.value.langKey == langInfo.langKey)
                    MyImage(
                      'default/selected'.svgAssets(),
                      width: 20.w,
                      height: 20.w,
                    ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
