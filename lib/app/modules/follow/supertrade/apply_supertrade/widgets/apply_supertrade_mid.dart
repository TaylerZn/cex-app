import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/supertrade/apply_supertrade/model/follow_super_model.dart';
import 'package:nt_app_flutter/app/modules/follow/supertrade/apply_supertrade/controllers/apply_supertrade_controller.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

//

class ApplySupertradeMid extends StatelessWidget {
  const ApplySupertradeMid({super.key, required this.controller});
  final ApplySupertradeController controller;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 10.h),
        child: Column(
          children: <Widget>[
            controller.model.list?.isNotEmpty == true
                ? SizedBox(
                    height: 320.h,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, mainAxisSpacing: 10, childAspectRatio: 1.68),
                      itemCount: controller.model.list!.length,
                      itemBuilder: (context, index) {
                        return PersonCard(person: controller.model.list![index]);
                      },
                    ),
                  )
                : const SizedBox(),
            SizedBox(height: 10.h),
            Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 24.h, bottom: 20.h),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: AppColor.colorBlack),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text.rich(TextSpan(children: [
                            TextSpan(
                              text: LocaleKeys.follow260.tr,
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: AppColor.colorFFFFFF,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: LocaleKeys.follow261.tr,
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: AppColor.mainColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ]))
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Wrap(
                    children: <Widget>[
                      Text(
                        LocaleKeys.follow268.tr,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColor.colorFFFFFF,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  // Icon(Icons.chevron_right, size: 22.sp)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PersonCard extends StatelessWidget {
  final FollowSuperModel person;
  const PersonCard({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.h),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColor.colorECECEC,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyImage(
            person.icon,
            width: 170.w,
            height: 170.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 14.h),
            child: Row(
              children: <Widget>[
                Text(person.userNmae,
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColor.color111111,
                      fontWeight: FontWeight.w600,
                    ))
              ],
            ),
          ),
          Row(
            children: <Widget>[
              getWidget('${LocaleKeys.follow295.tr} USDT', person.profitAmountStr),
              SizedBox(width: 2.w),
              getWidget(LocaleKeys.follow188.tr, person.profitAmountRateStr, color: person.profitAmountRateClor),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: <Widget>[
              getWidget('${LocaleKeys.follow294.tr} USDT', person.balanceStr),
              SizedBox(width: 2.w),
              getWidget(LocaleKeys.follow227.tr, person.currentNumberStr),
            ],
          ),
        ],
      ),
    );
  }

  Widget getWidget(String title, String des, {Color? color}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: AppTextStyle.f_11_400.colorABABAB.ellipsis),
          Text(des, style: color == null ? AppTextStyle.f_12_600.color111111 : AppTextStyle.f_12_600.copyWith(color: color))
        ],
      ),
    );
  }
}
