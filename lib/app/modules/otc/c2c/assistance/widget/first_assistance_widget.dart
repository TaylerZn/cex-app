import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/assistance/controllers/assistance_controller.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/assistance/widget/timeline_tile/style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/assistance/widget/timeline_tile/tile.dart';

import '../../../../../../generated/locales.g.dart';

class FirstAssistanceWidget extends StatelessWidget {
  final AssistanceController controller;
  const FirstAssistanceWidget({super.key, required this.controller});

  Widget buildContent(int index) {
    Widget buildRowContent(String title, String value) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyle.f_12_400.color999999),
          Text(value, style: AppTextStyle.f_12_400.color333333)
        ],
      );
    }

    Widget buildContent() {
      switch (index) {
        case 0:
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LocaleKeys.c2c119.tr,
                  style: AppTextStyle.f_14_500.color666666),
              SizedBox(height: 10.h),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColor.colorF5F5F5,
                    borderRadius: BorderRadius.all(Radius.circular(6.r)),
                  ),
                  child: Column(
                    children: [
                      buildRowContent(LocaleKeys.c2c120.tr,
                          '${controller.model?.price}${controller.model?.paycoin}'),
                      16.verticalSpace,
                      buildRowContent(LocaleKeys.c2c121.tr,
                          '${controller.model?.orderPayment?.title ?? '-'}'),
                      16.verticalSpace,
                      buildRowContent(LocaleKeys.c2c9.tr,
                          '${controller.model?.orderPayment?.account}'),
                    ],
                  )),
              SizedBox(height: 16.h)
            ],
          );
        case 1:
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LocaleKeys.c2c119.tr,
                  style: AppTextStyle.f_14_500.color666666),
              20.verticalSpace,
              Text(LocaleKeys.c2c62.tr,
                  style: AppTextStyle.f_12_500.color333333),
              6.verticalSpace,
              Text(LocaleKeys.c2c124.tr,
                  style: AppTextStyle.f_12_400.color666666),
            ],
          );
      }
      return SizedBox();
    }

    return Container(
      margin: EdgeInsets.only(left: 8.w),
      child: buildContent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(LocaleKeys.c2c109.tr, style: AppTextStyle.f_20_600),
            6.verticalSpace,
            Text(LocaleKeys.c2c118.tr),
            24.verticalSpace,
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                  border: Border.all(color: AppColor.colorEEEEEE),
                  borderRadius: BorderRadius.all(Radius.circular(6.r))),
              child: ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  final example = buildContent(index);

                  return TimelineTile(
                    alignment: TimelineAlign.start,
                    // lineXY: 0.1,
                    // isFirst: index == 0,
                    isLast: index == 1,
                    indicatorStyle: IndicatorStyle(
                      width: 18.w,
                      height: 18.h,
                      indicator: Container(
                        decoration: BoxDecoration(
                            color: AppColor.color111111,
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.r))),
                        alignment: Alignment.center,
                        child: Text('${index + 1}',
                            textAlign: TextAlign.center,
                            style: AppTextStyle.f_12_600.colorWhite),
                      ),
                      drawGap: true,
                    ),

                    endChild: example,
                  );
                },
              ),
            )
          ],
        ));
  }
}
