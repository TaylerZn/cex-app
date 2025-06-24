import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_search_text_field.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

abstract class SearchTopController {
  Rx<TextEditingController> textEditVC = TextEditingController().obs;

  void onSubmit(String text);
}

getSearchTopView(SearchTopController controller) {
  return SizedBox(
    height: 44.w,
    child: Row(
      children: [
        Expanded(
            child: MySearchTextField(
          height: 32.w,
          textEditingController: controller.textEditVC.value,
          margin: EdgeInsets.symmetric(horizontal: 16.w),
          hintText: LocaleKeys.public9.tr,
          onSubmitted: (String val) {
            controller.onSubmit(val);
          },
          onCancelTap: () {
            Get.back();
          },
        ))
      ],
    ),
  );
}
