import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../routes/app_pages.dart';

//

class ApplySuperTradeTop extends StatelessWidget {
  const ApplySuperTradeTop({super.key, required this.messageArray});
  final List<String> messageArray;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Stack(children: [
            SizedBox(
              // 'assets/images/my/apply_supertrade_top.png',
              height: 198.h,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16, MediaQuery.of(context).padding.top + 64.h, 16, 8.h),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Row(
                      children: <Widget>[
                        Text(LocaleKeys.follow260.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColor.color111111,
                              fontWeight: FontWeight.w700,
                            )),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8, top: 6.h, bottom: 6.h),
                    child: Row(
                      children: <Widget>[
                        Text(LocaleKeys.follow261.tr,
                            style: TextStyle(
                              fontSize: 30.sp,
                              color: AppColor.color111111,
                              fontWeight: FontWeight.w900,
                            ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 100.w),
                    child: Text(LocaleKeys.follow262.tr,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColor.color111111.withAlpha(204),
                          fontWeight: FontWeight.w400,
                        )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 13.h),
                    padding: EdgeInsets.only(top: 9.h, bottom: 10.h, left: 9),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColor.colorBlack),
                    child: DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColor.colorFFFFFF.withAlpha(204),
                          fontWeight: FontWeight.w400,
                        ),
                        child: Column(
                            children: messageArray
                                .map(
                                  (e) => Padding(
                                    padding: EdgeInsets.symmetric(vertical: 4.h),
                                    child: Row(
                                      children: <Widget>[
                                        MyImage(
                                          'assets/images/my/apply_supertrade_select.png',
                                          width: 16.w,
                                          height: 16.h,
                                        ),
                                        const SizedBox(width: 8),
                                        Expanded(child: Text(e))
                                      ],
                                    ),
                                  ),
                                )
                                .toList())),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 8,
              left: 16,
              child: GestureDetector(
                  onTap: () => Get.back(),
                  behavior: HitTestBehavior.translucent,
                  child: Padding(
                    padding: EdgeInsets.only(right: 18.w),
                    child: MyImage(
                      'default/page_back'.svgAssets(),
                      width: 18.w,
                      height: 18.w,
                      color: AppColor.color111111,
                    ),
                  )),
            ),
            Positioned(
                top: MediaQuery.of(context).padding.top,
                right: 0,
                child: MyImage(
                  'assets/images/my/apply_supertrade_topR.png',
                  width: 85.w,
                  height: 78.h,
                )),
            Positioned(
                top: MediaQuery.of(context).padding.top + 60.h,
                right: 16,
                child: MyImage(
                  'assets/images/my/apply_supertrade_crown.png',
                  width: 145.w,
                  height: 123.h,
                ))
          ]),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16.h),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () => Get.toNamed(Routes.FOLLOW_TAKER_LIST, arguments: {'index': 0}),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(LocaleKeys.follow266.tr,
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColor.color111111,
                            fontWeight: FontWeight.w600,
                          )),
                      Row(
                        children: <Widget>[
                          Text(LocaleKeys.trade187.tr,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: AppColor.color999999,
                                fontWeight: FontWeight.w600,
                              )),
                          const Icon(Icons.chevron_right)
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Wrap(
                  children: <Widget>[
                    Text(LocaleKeys.follow267.tr,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColor.color4D4D4D,
                          fontWeight: FontWeight.w400,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
