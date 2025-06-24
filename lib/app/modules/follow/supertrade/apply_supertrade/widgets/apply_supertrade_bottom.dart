import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/links_Getx.dart';
import 'package:nt_app_flutter/app/modules/follow/supertrade/apply_supertrade/controllers/apply_supertrade_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/supertrade/apply_supertrade/model/apply_supertrade_help.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

//

class ApplySupertradeBottom extends StatelessWidget {
  const ApplySupertradeBottom({super.key, required this.helpArray});
  final List<ApplySupertradeHelp> helpArray;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, bottom: 200.h),
        padding: EdgeInsets.only(left: 16, right: 16, top: 24.h, bottom: 16.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: AppColor.colorWhite),
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Text(LocaleKeys.user84.tr,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: AppColor.color111111,
                      fontWeight: FontWeight.w600,
                    ))
              ],
            ),
            SizedBox(height: 16.h),
            Container(height: 1.0, color: AppColor.colorDCDCDC),
            // MediaQuery.removePadding(
            //   removeTop: true,
            //   removeBottom: true,
            //   context: context,
            //   child: ListView(
            //     physics: const NeverScrollableScrollPhysics(),
            //     shrinkWrap: true,
            //     children: helpArray.map((ApplySupertradeHelp item) {
            //       return Theme(
            //         data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            //         child: ExpansionTile(
            //           tilePadding: const EdgeInsets.all(0),
            //           collapsedTextColor: Colors.green,
            //           iconColor: AppColor.color4D4D4D,
            //           collapsedIconColor: AppColor.color4D4D4D,
            //           title: Text(item.header,
            //               style: TextStyle(
            //                 fontSize: 14.sp,
            //                 color: AppColor.color111111,
            //                 fontWeight: FontWeight.w500,
            //               )),
            //           children: [
            //             ListTile(
            //               title: Container(
            //                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColor.colorF5F5F5),
            //                 padding: EdgeInsets.all(10.w),
            //                 child: Text(item.expanded,
            //                     style: TextStyle(
            //                       fontSize: 12.sp,
            //                       color: AppColor.color4D4D4D,
            //                       fontWeight: FontWeight.w400,
            //                     )),
            //               ),
            //             ),
            //           ],
            //         ),
            //       );
            //     }).toList(),
            //   ),
            // ),

            InkWell(
              onTap: () {
                Get.toNamed(Routes.WEBVIEW,
                    arguments: {'url': LinksGetx.to.onlineServiceProtocal});
              },
              child: Container(
                margin: EdgeInsets.only(top: 20.h),
                padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
                // clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side:
                        const BorderSide(width: 1, color: AppColor.color111111),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MyImage(
                      'assets/images/my/apply_supertrade_service.png',
                      width: 16.w,
                      height: 16.h,
                    ),
                    SizedBox(width: 5.w),
                    Text(LocaleKeys.user87.tr,
                        style: AppTextStyle.f_12_600.color111111)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ApplySupertradeBottomButton extends StatelessWidget {
  const ApplySupertradeBottomButton({super.key, required this.controller});
  final ApplySupertradeController controller;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: controller.btnStr.isNotEmpty
            ? DecoratedBox(
                decoration: const BoxDecoration(color: AppColor.colorWhite),
                child: GestureDetector(
                  onTap: () {
                    if (controller.status == -1) {
                      Get.toNamed(Routes.APPLY_SUPERTRADER_STATES);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.only(
                        top: 16.h,
                        bottom: 16.h + MediaQuery.of(context).padding.bottom,
                        right: 24.w,
                        left: 24.w),
                    padding: EdgeInsets.symmetric(horizontal: 24.h),
                    height: 48.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: controller.status == -1
                            ? AppColor.color111111
                            : const Color(0XFF222222)),
                    alignment: Alignment.center,
                    child: controller.status == -1
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                controller.btnStr,
                                style: AppTextStyle.f_16_500.colorWhite,
                              ),
                              MyImage(
                                'flow/follow_setup_arrow'.svgAssets(),
                                height: 24.r,
                                width: 24.r,
                                color: AppColor.colorWhite,
                              ),
                            ],
                          )
                        : Text(
                            controller.btnStr,
                            style: AppTextStyle.f_16_500.colorWhite,
                          ),
                  ),
                ),
              )
            : const SizedBox());
  }
}
