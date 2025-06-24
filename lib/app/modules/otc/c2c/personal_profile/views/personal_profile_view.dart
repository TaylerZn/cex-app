import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/my/widget/verify_info_widget.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/personal_profile/views/personal_record.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';
import 'package:nt_app_flutter/app/widgets/components/user_avatar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../transation/entrust/widgets/entrust_tabbar.dart';
import '../controllers/personal_profile_controller.dart';

class PersonalProfileView extends GetView<PersonalProfileController> {
  const PersonalProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PersonalProfileController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          leading: MyPageBackWidget(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            16.h.verticalSpace,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserAvatar(
                    controller.userInfo?.headImage,
                    width: 60.w,
                    height: 60.w,
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      Text(controller.userInfo?.nickName ?? '-',
                          style: AppTextStyle.f_20_600),
                      SizedBox(width: 4.w),
                      Visibility(
                        visible: UserGetx.to.isKyc,
                        child: MyImage(
                          'otc/c2c/verify_emblem'.svgAssets(),
                          width: 18.w,
                          height: 18.w,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16.h),
                  VerifyInfoWidget(userInfo: controller.userInfo),
                ],
              ),
            ),
            controller.userInfo?.isMerchant == true
                ? merchantView()
                : normalView()
          ],
        ),
      );
    });
  }

  Widget normalView() {
    return Column(
      children: [
        16.verticalSpace,
        Container(
          height: 1,
          color: AppColor.colorEEEEEE,
        ),
        _buildHistory(),
        Container(
          height: 1,
          color: AppColor.colorEEEEEE,
        ),
      ],
    );
  }

  Widget merchantView() {
    return Expanded(
        child: Column(
      children: [
        Visibility(
            visible: controller.userInfo?.isMerchant == true,
            child: Column(
              children: [
                10.h.verticalSpace,
                EntrustTabbar(
                  dataArray: ['信息', '广告(${controller.dataList?.length ?? 0})'],
                  controller: controller.tab,
                ),
              ],
            )),
        Expanded(
          child: TabBarView(controller: controller.tab, children: [
            KeepAliveWrapper(child: _buildHistory()),
            KeepAliveWrapper(child: PersonalRecordPage())
          ]),
        )
      ],
    ));
  }

  Widget _buildHistory() {
    Widget buildContent(String title, String subTitle, TextStyle style) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: AppTextStyle.f_14_400.color666666),
          Text(subTitle, style: style)
        ],
      );
    }

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            SizedBox(height: 17.h),
            buildContent(
                LocaleKeys.c2c4.tr,
                '${controller.userInfo?.completeOrders ?? 0}',
                AppTextStyle.f_14_600),
            SizedBox(height: 10.h),
            buildContent(
                LocaleKeys.c2c5.tr,
                controller.userInfo?.completeOrderRate ?? '0%',
                AppTextStyle.f_14_600),
            SizedBox(height: 10.h),
            buildContent(
                LocaleKeys.c2c6.tr,
                controller.userInfo?.payTime ?? '00:00:00',
                AppTextStyle.f_14_400),
            SizedBox(height: 10.h),
            buildContent(
                LocaleKeys.c2c7.tr,
                controller.userInfo?.passTime ?? '00:00:00',
                AppTextStyle.f_14_400),
            SizedBox(height: 16.h),
          ],
        ));
  }

  Widget buildTabbar() {
    return Container(
      color: AppColor.colorWhite,
      // color: Colors.yellow,
      alignment: Alignment.centerLeft,
      // color: Colors.green,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      height: 22.h,
      child: Stack(
        children: [
          TabBar(
            onTap: (index) {},
            controller: controller.tab,
            isScrollable: true,
            unselectedLabelColor: AppColor.colorABABAB,
            labelColor: AppColor.color111111,
            // labelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, ),
            // unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 12.sp, ),

            labelStyle: AppTextStyle.f_12_500,
            unselectedLabelStyle: AppTextStyle.f_12_500,
            indicatorSize: TabBarIndicatorSize.tab,
            // indicatorPadding: EdgeInsets.only(left: 0, right: 0, top: 4.h, bottom: 4.h),
            labelPadding:
                EdgeInsets.only(left: 10.w, right: 10.w, top: 2.w, bottom: 0),
            indicator: BoxDecoration(
                // color: AppColor.colorEEEEEE,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: AppColor.color111111)),
            tabs: ['信息', '广告']
                .map((f) => Tab(
                      child: Text(f),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}
