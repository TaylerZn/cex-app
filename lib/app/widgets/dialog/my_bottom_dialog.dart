import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';

// 显示弹窗
Future showMyBottomDialog(context, child,
    {isDismissible = true,
    backgroundColor = AppColor.colorWhite,
    EdgeInsetsGeometry? padding,
    isPaddingBottom = true}) {
  return showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: isDismissible,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
            child: AnimatedPadding(
          duration: const Duration(milliseconds: 100),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: GestureDetector(
              onTap: () {
                // 触摸收起键盘
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Container(
                  padding:
                      (padding ?? EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 16.h))
                          .add(EdgeInsets.only(
                              bottom: isPaddingBottom
                                  ? MediaQuery.of(context).padding.bottom
                                  : 0)),
                  decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(15)),
                      color: backgroundColor),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [child],
                  ))),
        ));
      });
}
