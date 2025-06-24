import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

Future<T?> showBSheet<T>(Widget widget,
    {bool enableDrag = true, RoundedRectangleBorder? shape}) async {
  return showMaterialModalBottomSheet(
    isDismissible: true,
    backgroundColor: Colors.white,
    enableDrag: enableDrag,
    shape: shape ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.w),
            topRight: Radius.circular(10.w),
          ),
        ),
    context: Get.context!,
    builder: (BuildContext context) {
      return  Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            widget,
            Get.mediaQuery.viewPadding.bottom.verticalSpace,
          ],
      );
    },
  );
}
