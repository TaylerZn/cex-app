import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/assets.dart';
import 'package:nt_app_flutter/app/enums/user.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/supertrade/Apply_supertrader_states/controllers/apply_supertrader_states_controller.dart';
import 'package:nt_app_flutter/app/modules/main_tab/controllers/main_tab_controller.dart';
import 'package:nt_app_flutter/app/modules/my/widgets/Kyc_Info_Page.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/getx_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

//

class ApplySuperTradeStatesTop extends StatelessWidget {
  const ApplySuperTradeStatesTop({super.key, required this.controller});
  final ApplySupertraderStatesController controller;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Stack(children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                  16, MediaQuery.of(context).padding.top + 64.h, 16, 8.h),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 6.h, bottom: 10.h),
                    child: Row(
                      children: <Widget>[
                        Text(LocaleKeys.follow261.tr,
                            style: TextStyle(
                              fontSize: 30.sp,
                              color: AppColor.colorWhite,
                              fontWeight: FontWeight.w900,
                            ))
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Row(
                        children: [
                          MyImage(
                            'my/apply_supertrade_yellow'.svgAssets(),
                            width: 12.w,
                            height: 12.h,
                          ),
                          SizedBox(width: 4.w),
                          Text(LocaleKeys.follow269.tr,
                              style: AppTextStyle.f_12_400.colorWhite),
                        ],
                      ),
                      SizedBox(width: 16.w),
                      Row(
                        children: [
                          MyImage(
                            'my/apply_supertrade_yellow'.svgAssets(),
                            width: 12.w,
                            height: 12.h,
                          ),
                          SizedBox(width: 4.w),
                          Text(LocaleKeys.follow270.tr,
                              style: AppTextStyle.f_12_400.colorWhite),
                        ],
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 23.h),
                      padding:
                          EdgeInsets.only(top: 20.h, left: 16.w, right: 16.w),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: AppColor.color1A1A1A),
                      child: getTopView()),
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
                      color: AppColor.colorWhite,
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
            padding: EdgeInsets.fromLTRB(16.w, 30.h, 16.w, 130.h),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(LocaleKeys.follow279.tr,
                        style: AppTextStyle.f_18_600.colorWhite)
                  ],
                ),
                SizedBox(height: 24.h),
                getStatesView()
              ],
            ),
          ),
        ],
      ),
    );
  }

  getTopView() {
    return Column(
        children: controller.messageArray
            .map(
              (e) => Padding(
                padding: EdgeInsets.only(bottom: 22.h),
                child: Row(
                  children: <Widget>[
                    MyImage(
                      'my/apply_supertrade_top${e.icon}'.svgAssets(),
                      width: 24.w,
                      height: 24.h,
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            e.title,
                            style: AppTextStyle.f_14_600.colorWhite,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            e.des,
                            style: AppTextStyle.f_12_400
                                .copyWith(color: const Color(0xFFAAAAAA)),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
            .toList());
  }

  getStatesView() {
    return Column(
        children: controller.statesArray
            .map(
              (e) => Container(
                margin: EdgeInsets.only(bottom: 16.h),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 26.h),
                decoration: ShapeDecoration(
                  color: e.isSuccess
                      ? const Color(0xFF0B0C0F)
                      : AppColor.color1A1A1A,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFF222222)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: GestureDetector(
                  onTap: () async {
                    if (!e.isSuccess) {
                      if (e.icon == '1') {
                        if (UserGetx.to.getAuthStatus == UserAuditStatus.noSubmit) {
                          await Get.toNamed(Routes.KYC_INDEX);
                          controller.checkApplyTrader();
                        } else {
                          await Get.to(KycInfoPage());
                          controller.checkApplyTrader();
                        }
                      } else if (e.icon == '2') {
                        await Get.toNamed(Routes.CURRENCY_SELECT, arguments: {
                          'type': AssetsCurrencySelectEnumn.depoit
                        });
                        controller.checkApplyTrader();
                      } else if (e.icon == '6') {
                        await Get.toNamed(Routes.MY_INVITE);
                        controller.checkApplyTrader();
                      } else {
                        Get.untilNamed(Routes.MAIN_TAB);
                        MainTabController.to.changeTabIndex(2);
                      }
                    }
                  },
                  behavior: HitTestBehavior.translucent,
                  child: Row(
                    children: <Widget>[
                      MyImage(
                        'assets/images/my/apply_supertrade_mid${e.icon}.png',
                        width: 18.w,
                        height: 18.h,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          e.title,
                          style: AppTextStyle.f_14_600.colorWhite,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      e.isSuccess
                          ? MyImage('my/apply_supertrade_succse'.svgAssets(),
                              height: 16.r, width: 16.r)
                          : Row(
                              children: <Widget>[
                                Text(
                                  e.des,
                                  style: AppTextStyle.f_12_400
                                      .copyWith(color: const Color(0xFFACB1B5)),
                                ),
                                SizedBox(width: 10.w),
                                MyImage(
                                  'default/go'.svgAssets(),
                                  height: 14.r,
                                  width: 14.r,
                                  color: AppColor.colorWhite,
                                ),
                              ],
                            )
                    ],
                  ),
                ),
              ),
            )
            .toList());
  }
}
