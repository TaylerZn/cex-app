import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_more_list/loading_more_list.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_setup/controllers/follow_setup_controller.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

//

class FollowSetupTop extends StatelessWidget {
  const FollowSetupTop({
    super.key,
    required this.trader,
    this.currentPosition = false,
    this.haveRate = false,
    this.controller,
  });
  final FollowKolInfo trader;
  final bool currentPosition;
  final bool haveRate;
  final FollowSetupController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            UserAvatar(
              trader.icon,
              width: 44.w,
              height: 44.w,
              levelType: trader.levelType,
              isTrader: true,
            ),

            // Container(
            //   width: 44.w,
            //   height: 44.w,
            //   decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), borderRadius: BorderRadius.circular(32.w)),
            //   child: ClipOval(
            //     child: MyImage(
            //       trader.icon,
            //     ),
            //   ),
            // ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(trader.userName, style: AppTextStyle.f_16_500.color111111),
                Offstage(
                  offstage: false,
                  child: Padding(
                    padding: EdgeInsets.only(top: 10.h),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LocaleKeys.follow8.tr, style: AppTextStyle.f_11_400.color999999).marginOnly(bottom: 4.h),
                            Text(trader.monthProfitRateStr,
                                style: AppTextStyle.f_11_500.copyWith(color: trader.monthProfitRateColor))
                          ],
                        ),
                        SizedBox(width: 30.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LocaleKeys.follow9.tr, style: AppTextStyle.f_11_400.color999999).marginOnly(bottom: 4.h),
                            Text(trader.winRateStr, style: AppTextStyle.f_11_500.copyWith(color: trader.winRateColor))
                          ],
                        ),
                        SizedBox(width: 30.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LocaleKeys.follow184.tr, style: AppTextStyle.f_11_400.color999999).marginOnly(bottom: 4.h),
                            Text('${trader.rate}%', style: AppTextStyle.f_11_500.copyWith(color: trader.winRateColor))
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(top: 12.h, bottom: trader.labelStr.isNotEmpty ? 12.h : 0),
        child: ExpandableText(
          trader.labelStr,
          expandText: LocaleKeys.follow112.tr,
          collapseText: LocaleKeys.follow113.tr,
          maxLines: 2,
          linkColor: AppColor.color111111,
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColor.color666666,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      Container(
        color: AppColor.colorEEEEEE,
        height: 1.w,
      ).marginOnly(bottom: 20.h),
      currentPosition
          ? Obx(() => controller!.currentOrder.value.list != null && controller!.currentOrder.value.list!.isNotEmpty
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(LocaleKeys.follow114.tr, style: AppTextStyle.f_15_500.color111111),
                    SizedBox(
                      height: 94.w, //
                      child: WaterfallFlow.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller!.currentOrder.value.list!.length,
                        gridDelegate: SliverWaterfallFlowDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.w,
                        ),
                        itemBuilder: (context, index) {
                          var model = controller!.currentOrder.value.list![index];
                          return Container(
                              width: 149.w,
                              padding: EdgeInsets.all(12.w),
                              decoration: BoxDecoration(
                                  // color: Colors.red,
                                  border: Border.all(color: AppColor.colorEEEEEE),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(LocaleKeys.follow115.tr, style: AppTextStyle.f_11_400.color999999),
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.h, bottom: 10.h),
                                    child: Text(model.earningsRateStr,
                                        style: AppTextStyle.f_16_600.copyWith(color: model.earningsRateColor)),
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                                        decoration: BoxDecoration(
                                            color: model.tagColor.withOpacity(0.1), borderRadius: BorderRadius.circular(2)),
                                        child: Text(model.tag, style: AppTextStyle.f_10_500.copyWith(color: model.tagColor)),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                                        margin: EdgeInsets.symmetric(horizontal: 4.w),
                                        constraints: BoxConstraints(maxWidth: 50.w),
                                        decoration:
                                            BoxDecoration(color: AppColor.colorF4F4F4, borderRadius: BorderRadius.circular(2)),
                                        child: Text(model.positionTypeStr,
                                            style: AppTextStyle.f_10_500.color333333.copyWith(overflow: TextOverflow.ellipsis)),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                                        constraints: BoxConstraints(maxWidth: 30.w),
                                        decoration:
                                            BoxDecoration(color: AppColor.colorF4F4F4, borderRadius: BorderRadius.circular(2)),
                                        child: Text(model.contractTypeStr,
                                            style: AppTextStyle.f_10_500.color333333.copyWith(overflow: TextOverflow.ellipsis)),
                                      )
                                    ],
                                  )
                                ],
                              ));
                        },
                      ),
                    ).marginOnly(top: 14.h, bottom: 21.h),
                  ],
                )
              : const SizedBox())
          : const SizedBox(),
    ]);
  }
}
