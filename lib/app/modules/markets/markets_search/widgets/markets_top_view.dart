import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_search_textField.dart';
import 'package:nt_app_flutter/app/modules/markets/markets_search/controllers/markets_search_controller.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

getMarketsTopView(MarketsSearchController controller) {
  return AppBar(
    leading: const MyPageBackWidget(),
    backgroundColor: AppColor.colorWhite,
    automaticallyImplyLeading: false,
    title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Expanded(
        child: Container(
            height: 32.w,
            margin: EdgeInsets.only(left: 16.w, right: 10.w),
            decoration: BoxDecoration(
              color: AppColor.colorF5F5F5,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Row(
              children: [
                Expanded(
                    child: SearchTextField(
                  height: 32,
                  controller: controller.textEditVC,
                  haveTopPadding: false,
                  hintText: LocaleKeys.public9.tr,
                  onChanged: (p) {
                    controller.searchTicker();
                  },
                )),
              ],
            )),
      ),
      GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          width: 44.w,
          height: 32.h,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: Colors.transparent),
          ),
          child: Text(LocaleKeys.public2.tr, style: AppTextStyle.f_14_500.color666666),
        ),
      )
    ]),
    titleSpacing: 0,
  );
}
