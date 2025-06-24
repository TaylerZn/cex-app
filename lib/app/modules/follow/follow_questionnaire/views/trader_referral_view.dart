import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/widgets/my_follow_list.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../routes/app_pages.dart';
import '../../../../widgets/basic/my_page_back.dart';
import '../../../../widgets/no/network_error_widget.dart';
import '../../follow_orders/model/follow_kol_model.dart';
import '../../follow_orders/widgets/follow_orders_item.dart';
import '../controllers/trader_referral_controller.dart';

class TraderReferralView extends GetView<TraderReferralController> {
  const TraderReferralView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyPageBackWidget(
            // backColor: AppColor.colorFFFFFF,
            ),
        title: Text(LocaleKeys.follow432.tr), //('专属交易员推荐'),
        centerTitle: true,
        actions: [
          Center(
            child: GestureDetector(
              onTap: () {
                // Get.back();
                // // Get.toNamed(Routes.FOLLOW_QUESTIONNAIRE_RESULT); //test
                //
                Get.toNamed(Routes.FOLLOW_QUESTIONNAIRE_RESULT, arguments: {
                  "model": controller.model,
                  "basicSupport": controller.basicSupport,
                  "liquidity": controller.liquidity,
                  "riskTolerance": controller.riskTolerance,
                  "investmentKnowledge": controller.investmentKnowledge,
                  "investmentPreference": controller.investmentPreference
                });
              },
              child: Text(
                LocaleKeys.follow433.tr, // '查看报告',
                style: AppTextStyle.f_13_600.color111111,
              ),
            ),
          ).paddingOnly(right: 16.w)
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          16.verticalSpace,
          Container(color: Colors.white, child: MyFollowStudy()),
          16.verticalSpace,
          Text.rich(TextSpan(children: [
            TextSpan(
                text: LocaleKeys.follow434.tr,
                style: AppTextStyle.f_16_600.color111111), //这些
            TextSpan(
                text: ' ${controller.model["tag"].toString().tr} ',
                style: AppTextStyle.f_16_600.colorF6465D), //高风险高回报
            TextSpan(
                text: LocaleKeys.follow436.tr,
                style: AppTextStyle.f_16_600.color111111), //交易员可能更适合您
          ])).paddingSymmetric(horizontal: 16.w),
          16.verticalSpace,
          Expanded(child: Obx(() {
            if (controller.isError.value) {
              return NetworkErrorWidget(
                onTap: () {
                  controller.fetchData();
                },
              );
            }
            return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemBuilder: (context, index) {
                  FollowKolInfo model = controller.list[index];
                  // return item(model);
                  return FollowOrdersItem(isRecommend: true, model: model);
                },
                separatorBuilder: (context, index) {
                  return 12.verticalSpace;
                },
                itemCount: controller.list.length);
          }))
        ],
      ),
    );
  }
}
