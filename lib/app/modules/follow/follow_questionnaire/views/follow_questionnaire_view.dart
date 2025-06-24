import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/widgets/follow_orders_item.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_questionnaire/widget/follow_question_draw.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/widgets/my_follow_list.dart';
import 'package:nt_app_flutter/app/modules/main_tab/controllers/main_tab_controller.dart';
import 'package:nt_app_flutter/app/utils/extension/getx_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_dotted_text.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../routes/app_pages.dart';
import '../../../../widgets/basic/my_page_back.dart';
import '../controllers/follow_questionnaire_controller.dart';

class FollowQuestionnaireView extends GetView<FollowQuestionnaireController> {
  const FollowQuestionnaireView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.color1F1E20,
      appBar: AppBar(
        // title: const Text(''),
        // centerTitle: true,
        leading: MyPageBackWidget(
          backColor: AppColor.colorFFFFFF,
          onTap: () {
            Get.back();
            // Get.dialog(quitDialog());
          },
        ),
        backgroundColor: AppColor.transparent,
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0.w,
            right: -22.w,
            child: MyImage(
              'flow/union'.svgAssets(),
              width: 143.w,
            ),
          ),
          Positioned.fill(child: _buildQuestionnaire(context)),
        ],
      ),
    );
  }

  Widget _buildQuestionnaire(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h),
                    Text(
                      LocaleKeys.follow331.tr, // BITCOCO Risk Assessment
                      style: AppTextStyle.f_28_600.colorFFFFFF,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      LocaleKeys.follow332.tr,
                      // We will generate an investment risk assessment report for you based on your assessment results
                      maxLines: 2,
                      style: AppTextStyle.f_12_400.color666666,
                    ),
                    SizedBox(height: 40.h),
                    RichText(
                      text: TextSpan(
                        text: LocaleKeys.follow333.tr + ' ', // 'Let us understand your ',
                        style: AppTextStyle.f_28_600.color666666,
                        children: <TextSpan>[
                          TextSpan(
                            text: LocaleKeys.follow334.tr + ' ', // 'Financial Preferences ',
                            style: AppTextStyle.f_28_600.colorFFD429, // 金黄色
                          ),
                          TextSpan(
                            text: LocaleKeys.follow335.tr + ' ', // 'and ',
                            style: AppTextStyle.f_28_600.color7E7E7E,
                          ),
                          TextSpan(
                            text: LocaleKeys.follow336.tr + ' ', // 'Risk Assessment ',
                            style: AppTextStyle.f_28_600.colorFFFFFF, // 白色
                          ),
                          TextSpan(
                            text: "${LocaleKeys.follow337.tr}",
                            // 'so that we can recommend you the investor style and portfolio products that suit you!',
                            style: AppTextStyle.f_28_600.color7E7E7E,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h), // 可以根据需要添加更多的间距
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h), // 可以根据需要添加更多的间距
          MyButton(
            text: LocaleKeys.follow338.tr,
            // Start Now
            color: AppColor.color111111,
            textStyle: AppTextStyle.f_16_600,
            backgroundColor: AppColor.colorFFFFFF,
            width: 343.w,
            height: 48.h,
            borderRadius: BorderRadius.circular(60.r),
            onTap: () {
              Get.log('FollowQuestionnaireView _buildQuestionnaire onTap');
              Get.offAndToNamed(Routes.FOLLOW_QUESTIONNAIRE_DETAILS);
              // Get.toNamed('/follow_questionnaire');//TODO: 跳转���风险评估页答题页
            },
          ),
          SizedBox(height: 20.h),
          Center(
            child: GestureDetector(
              // behavior: HitTestBehavior.translucent,
              onTap: () {
                Get.log('View our traders tapped');
                Get.untilNamed(Routes.MAIN_TAB);
                MainTabController.to.changeTabIndex(3); // TODO: 跳转到交易员页面// TODO: 跳转到交易员页面
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Container(
                  height: 18.h,
                  child: IntrinsicWidth(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          LocaleKeys.follow339.tr, // 'View our traders '
                          style: AppTextStyle.f_12_400.colorCCCCCC,
                        ),
                        Container(
                          height: 1, // 下划线高度
                          width: double.infinity, // 设置下划线宽度为无限
                          // margin: EdgeInsets.symmetric(horizontal: 0), // 设置下划线左右对齐
                          color: AppColor.colorCCCCCC, // 下划线颜色
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget quitDialog() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 16.w),
        width: 280,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.w), color: AppColor.colorFFFFFF),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.follow419.tr, //'提示',
              style: AppTextStyle.f_16_600.color111111,
            ),
            8.verticalSpace,
            Text(
              LocaleKeys.follow420.tr, //'退出后测试进度将被清空,\n确定要退出测试吗?',
              style: AppTextStyle.f_13_400.color4D4D4D,
              textAlign: TextAlign.center,
            ),
            20.verticalSpace,
            MyButton(
              onTap: () {
                Get.back();
                Get.back();
                Get.back();
              },
              height: 36,
              backgroundColor: AppColor.downColor,
              text: LocaleKeys.public1.tr, //'确定',
              textStyle: AppTextStyle.f_14_600.colorFFFFFF,
            ),
            4.verticalSpace,
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                height: 36,
                color: AppColor.colorFFFFFF,
                alignment: Alignment.center,
                child: Text(
                  LocaleKeys.public2.tr, //'取消',
                  style: AppTextStyle.f_14_600.color666666,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
