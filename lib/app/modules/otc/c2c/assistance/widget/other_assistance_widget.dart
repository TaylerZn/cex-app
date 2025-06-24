import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/assistance/widget/timeline_tile/style.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/assistance/widget/timeline_tile/tile.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

class OtherAssistanceWidget extends StatelessWidget {
  final int type;
  final String title;

  OtherAssistanceWidget({super.key, required this.type, required this.title});
  final List<List<String>> list = [
    [LocaleKeys.c2c125.tr, LocaleKeys.c2c123.tr, LocaleKeys.c2c127.tr],
    [LocaleKeys.c2c128.tr, LocaleKeys.c2c129.tr],
    [
      LocaleKeys.c2c130.tr,
      LocaleKeys.c2c131.tr,
      LocaleKeys.c2c132.tr,
      LocaleKeys.c2c133.tr
    ],
  ];

  List<String> get content => list[type];
  Widget buildContent(int index) {
    Widget buildContent() {
      List<Widget> children = content.map((e) {
        int temp = content.indexOf(e);
        if (temp != content.length - 1) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(e, style: AppTextStyle.f_14_500.color666666),
              20.verticalSpace
            ],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(LocaleKeys.c2c127.tr,
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
      }).toList();
      return children[index];
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
            Text(title, style: AppTextStyle.f_20_600),
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
                itemCount: content.length,
                itemBuilder: (BuildContext context, int index) {
                  final example = buildContent(index);

                  return TimelineTile(
                    alignment: TimelineAlign.start,
                    // lineXY: 0.1,
                    // isFirst: index == 0,
                    isLast: index == content.length - 1,
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
