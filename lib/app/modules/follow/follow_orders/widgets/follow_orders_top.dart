// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:card_swiper/card_swiper.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/assets.dart';
import 'package:nt_app_flutter/app/enums/public.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/notice/notice.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/controllers/follow_orders_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_orders_model.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/number_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/components/activity_widget.dart';
import 'package:nt_app_flutter/app/widgets/components/assets/assets_balance.dart';
import 'package:nt_app_flutter/app/widgets/components/assets/assets_profit.dart';
import 'package:nt_app_flutter/app/widgets/components/guide/guide_index_view.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

//
class FollowOrdersTop extends StatelessWidget {
  const FollowOrdersTop({
    super.key,
    required this.controller,
  });

  final FollowOrdersController controller;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
        child: UserGetx.to.isLogin
            ? Padding(
                padding: EdgeInsets.only(top: 16.w),
                child: controller.isTrader
                    ? getTraderView(controller.model.topModel.kol)
                    : getUserView(controller.model.topModel.follow))
            : getNotLoginView());
  }

  getNotLoginView() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 24.w, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: LocaleKeys.follow457.tr,
                          style: AppTextStyle.f_22_600.copyWith(color: AppColor.tradingYel, height: 1.5)),
                      TextSpan(
                          text: ' ${LocaleKeys.follow458.tr}',
                          style: AppTextStyle.f_22_600.copyWith(color: AppColor.color111111, height: 1.5)),
                    ],
                  ),
                ),
              ),
              // MyImage('flow/follow_notlogin_top'.svgAssets(), width: 83.w, height: 71.h)
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyButton(
              backgroundColor: AppColor.colorBackgroundTertiary,
              minWidth: 165.5.w,
              height: 36.w,
              borderRadius: BorderRadius.circular(60.w),
              text: LocaleKeys.public69.tr,
              color: AppColor.colorTextSecondary,
              textStyle: AppTextStyle.f_14_600,
              onTap: () {
                Get.toNamed(Routes.LOGIN_REGISTERED);
              },
            ),
            MyButton(
              minWidth: 165.5.w,
              height: 36.w,
              backgroundColor: AppColor.colorBackgroundInversePrimary,
              borderRadius: BorderRadius.circular(60.w),
              text: LocaleKeys.user6.tr,
              textStyle: AppTextStyle.f_14_600,
              onTap: () {
                UserGetx.to.goIsLogin();
              },
            ),
          ],
        ).paddingOnly(left: 16.w, right: 16.w, top: 24.w, bottom: 8.w),
      ],
    );
  }

  getTraderView(FollowKolTraderInfoModel model) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.transparent),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text('${LocaleKeys.follow39.tr}(USDT)', style: AppTextStyle.f_12_400.color4D4D4D),
                    const Spacer(),
                    InkWell(
                      onTap: () => Get.toNamed(Routes.FOLLOW_TAKER_INFO, arguments: {'uid': model.uid}),
                      child: Row(
                        children: [
                          Text(LocaleKeys.follow42.tr, style: AppTextStyle.f_12_400.color4D4D4D),
                          4.horizontalSpace,
                          MyImage('default/go'.svgAssets(), width: 10.w)
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(model.waitProfitStr, style: AppTextStyle.f_38_600.color111111),
                        Row(
                          children: <Widget>[
                            Text('${LocaleKeys.follow40.tr}(USDT)', style: AppTextStyle.f_12_400.color999999),
                            const SizedBox(width: 4),
                            Text(model.i90TraderTotalAmountStr, style: AppTextStyle.f_14_500.color111111),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    MyButton(
                      text: LocaleKeys.follow41.tr,
                      color: AppColor.color111111,
                      textStyle: AppTextStyle.f_14_600,
                      backgroundColor: AppColor.colorF1F1F1,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      height: 36.h,
                      onTap: () => Get.toNamed(Routes.MY_TAKE, arguments: {'model': model}),
                    )
                  ],
                ).paddingOnly(bottom: 2.w),
                Row(
                  children: <Widget>[
                    MyImage('flow/follow_take_num'.svgAssets(), width: 10.w),
                    4.horizontalSpace,
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                              text: controller.model.topModel.kol.currentFollowCountStr,
                              style: AppTextStyle.f_14_500.color333333),
                          TextSpan(
                              text: controller.model.topModel.kol.maxFollowCountStr, style: AppTextStyle.f_14_500.color999999),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getUserView(FollowGeneralInfoModel model) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: Colors.white),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: <Widget>[
            Expanded(
              child: GetBuilder<AssetsGetx>(builder: (assetsGetx) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AssetsBalance(
                      title: LocaleKeys.follow44.tr,
                      balance: assetsGetx.followIncomeAmount,
                      tabType: AssetsTabEnumn.follow,
                    ),
                    SizedBox(height: 2.h),
                    AssetsProfit(
                        valueNum: assetsGetx.pnlFollowAmount,
                        title: LocaleKeys.follow45.tr,
                        value:
                            NumberUtil.mConvert(assetsGetx.pnlFollowAmount, isEyeHide: true, isRate: IsRateEnum.usdt, count: 2),
                        isTitleDotted: true,
                        hasPercent: false,
                        onTap: () {
                          UIUtil.showAlert(LocaleKeys.follow45.tr, content: LocaleKeys.follow46.tr);
                        }),
                  ],
                );
              }),
            ),
            SizedBox(
              height: 24.h,
            ),
            AppGuideView(
                order: 4,
                guideType: AppGuideType.follow,
                finishCallback: () {},
                child: MyButton(
                    text: LocaleKeys.follow47.tr,
                    color: AppColor.color333333,
                    textStyle: AppTextStyle.f_12_600,
                    backgroundColor: AppColor.colorF1F1F1,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    borderRadius: const BorderRadius.all(Radius.circular(46)),
                    height: 38.h,
                    onTap: () => Get.toNamed(Routes.MY_FOLLOW, arguments: {'model': model}))),
          ],
        ),
      ),
    );
  }
}

class FollowOrdersCustomerMid extends StatelessWidget {
  const FollowOrdersCustomerMid({
    super.key,
    required this.controller,
  });

  final FollowOrdersController controller;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Obx(() => controller.model.topModel.cmsModel.value.list?.isNotEmpty == true && controller.showNoti == true
              ? Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 0),
                  child: Container(
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(width: 1, color: AppColor.colorF5F5F5),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                      child: MyActivityWidget(
                          height: 76.w, havePagination: false, list: controller.model.topModel.cmsModel.value.list!)))
              : const SizedBox()),
          Obx(() => (controller.model.noticeModel.value?.noticeInfoList.isNotEmpty == true &&
                  controller.model.shownotice.value &&
                  controller.showNoti == true)
              ? Container(
                  height: 28.w,
                  margin: EdgeInsets.only(top: 16.w, left: 16.w, right: 16.w),
                  padding: EdgeInsets.only(left: 8.w, right: 14.w),
                  decoration: ShapeDecoration(
                    color: AppColor.colorF9F9F9,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  ),
                  child: Row(
                    children: [
                      MyImage('assets/asset_noti'.svgAssets(), width: 16.w, height: 16.w),
                      Expanded(
                        child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 11.w),
                            child: Swiper(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                NoticeInfo noticeInfo = controller.model.noticeModel.value!.noticeInfoList[index];
                                return InkWell(
                                  onTap: () {
                                    if (ObjectUtil.isNotEmpty(noticeInfo.content)) {
                                      Get.toNamed(Routes.WEBVIEW, arguments: {'url': noticeInfo.content});
                                    }
                                  },
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      controller.model.noticeModel.value?.noticeInfoList[index].title ?? '',
                                      style: AppTextStyle.f_11_400.colorTextDescription,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                );
                              },
                              itemCount: controller.model.noticeModel.value!.noticeInfoList.length,
                              autoplay: true,
                              loop: true,
                            )),
                      ),
                      InkWell(
                        onTap: () {
                          controller.model.shownotice.value = false;
                        },
                        child: MyImage(
                          'flow/follow_answer_close'.svgAssets(),
                          width: 12.w,
                          height: 12.w,
                          color: AppColor.color111111,
                        ),
                      ),
                    ],
                  ),
                )
              : const SizedBox()),
        ],
      ),
    );
  }
}
