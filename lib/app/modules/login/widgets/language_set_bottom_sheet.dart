import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nt_app_flutter/app/modules/my/language_set/controllers/language_set_controller.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../config/theme/app_color.dart';
import '../../../models/contract/res/public_info.dart';
import '../../../widgets/basic/my_image.dart';

class LanguageSetBottomSheet extends StatelessWidget {
  const LanguageSetBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final LanguageSetController controller = Get.find();
    return Container(
      padding: EdgeInsets.fromLTRB(
          0, 22.w, 0, MediaQuery.of(context).padding.bottom),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
        color: Color(0xffffffff),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _title(),
          22.verticalSpace,
          Container(
              constraints: BoxConstraints(maxHeight: 300.h),
              child: SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  itemCount: controller.langInfoList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _item(controller, controller.langInfoList[index]);
                  },
                ),
              ))
        ],
      ),
    );
  }

  Widget _title() {
    return Text(
      LocaleKeys.public7.tr,
      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
    );
  }

  Widget _item(LanguageSetController controller, LangInfo local) {
    return Obx(() {
      return InkWell(
        splashColor: AppColor.color111111.withOpacity(0.2), //水波纹颜色
        onTap: () async {
          controller.changeLange(local);
          Get.back();
        },
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 4.w),
          padding: EdgeInsets.fromLTRB(16.w, 12.w, 16.w, 12.w),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: controller.currentLang.value.langKey == local.langKey
                ? Border.all(
                    width: 1.w,
                    color: AppColor.color111111,
                  )
                : Border.all(
                    width: 1.w,
                    color: AppColor.colorBBBBBB,
                  ),
          ),
          child: Row(
            children: [
              Text(
                local.langName,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.color111111,
                    overflow: TextOverflow.ellipsis),
                maxLines: 1,
              ),
            ],
          ),
        ),
      );
    });
  }
}
