import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/enums/assets.dart';
import 'package:nt_app_flutter/app/enums/public.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_follow/controllers/assets_follow_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/controllers/follow_taker_info_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_taker_info/views/follow_taker_info_view.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/controllers/my_follow_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/my_follow/views/my_follow_view.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../config/theme/app_text_style.dart';
import '../../../../widgets/basic/my_dotted_text.dart';
import '../../../../widgets/components/assets/assets_balance.dart';
import '../../../../widgets/components/assets/assets_profit.dart';

class AssetsFollowView extends GetView<AssetsFollowController> {
  const AssetsFollowView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsFollowController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetBuilder<AssetsGetx>(builder: (assetsGetx) {
          return SmartRefresher(
              controller: controller.refreshController,
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: () async {
                await Future.wait([assetsGetx.getRefresh()]);
                controller.refreshController.refreshToIdle();
                controller.refreshController.loadComplete();
              },
              child: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(16.w, 12.w, 16.w, 16.w), //UI微调
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UserGetx.to.isKol ? buildKolTop(assetsGetx) : buildFollowTop(assetsGetx),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                      child: MyButton(
                                    borderRadius: BorderRadius.circular(60),
                                    backgroundColor: AppColor.colorBlack,
                                    textStyle: AppTextStyle.f_14_600,
                                    color: AppColor.colorWhite,
                                    height: 36.w,
                                    onTap: () => {controller.actionHandler(0)},
                                    text: controller.actions.first.tr,
                                  )),
                                  12.horizontalSpace,
                                  Expanded(
                                      child: MyButton(
                                    borderRadius: BorderRadius.circular(60),
                                    backgroundColor: AppColor.colorF1F1F1,
                                    textStyle: AppTextStyle.f_14_600,
                                    color: AppColor.colorBlack,
                                    height: 36.w,
                                    onTap: () => {controller.actionHandler(1)},
                                    text: controller.actions.last.tr,
                                  ))
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ];
                  },
                  body: getBodyVie()));
        }));
  }

  Widget getBodyVie() {
    var tag = 'assets${UserGetx.to.uid}';

    if (UserGetx.to.user?.info?.isKol == true) {
      Get.put(FollowTakerInfoController(), tag: tag, permanent: true); //交易员
    } else {
      Get.put<MyFollowController>(MyFollowController(), tag: tag, permanent: true);
    }

    return UserGetx.to.user?.info?.isKol == true ? FollowTakerInfoView(tagStr: tag) : MyFollowView(tag: tag);
  }

  buildFollowTop(AssetsGetx assetsGetx) {
    return Column(children: [
      AssetsBalance(
        title: LocaleKeys.assets5.tr,
        balance: assetsGetx.followInfoTotal,
        tabType: AssetsTabEnumn.follow,
      ),
      SizedBox(height: 2.h),
      AssetsProfit(
          valueNum: assetsGetx.pnlFollowAmount,
          //TODO: JH:跟单今日盈亏
          title: LocaleKeys.assets12.tr,
          value: NumberUtil.mConvert(assetsGetx.pnlFollowAmount, isEyeHide: true, isRate: IsRateEnum.usdt, count: 2),
          isTitleDotted: true,
          hasPercent: false,
          onTap: () {
            UIUtil.showAlert(LocaleKeys.assets12.tr, content: LocaleKeys.assets49.tr);
          }),
      Padding(
        padding: EdgeInsets.only(top: 16.w, bottom: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.w),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFF5F5F5)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${LocaleKeys.assets47.tr} ${'('}${TextUtil.isEmpty(assetsGetx.followInfoModel.symbol) ? "USDT" : assetsGetx.followInfoModel.symbol}${')'}',
                      style: AppTextStyle.f_12_400.color999999,
                    ),
                    // Text(
                    //     //跟单总金额
                    //     '${LocaleKeys.assets47.tr} ${'('}${TextUtil.isEmpty(assetsGetx.followInfoModel.symbol) ? "USDT" : assetsGetx.followInfoModel.symbol}${')'}',
                    //     style: AppTextStyle.small_500.colorABABAB),

                    Text(assetsGetx.followInfoModel.followSubAmount.toString(), style: AppTextStyle.f_16_600.color333333)
                        .paddingSymmetric(vertical: 4.w),

                    Text(
                        "≈${NumberUtil.mConvert(assetsGetx.followInfoModel.followSubAmount, isEyeHide: true, isRate: IsRateEnum.usdt)}",
                        style: AppTextStyle.f_12_400.color999999),
                  ],
                ),
              ),
            ),
            9.horizontalSpace,
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.w),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFF5F5F5)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${LocaleKeys.assets15.tr} ${'('}${TextUtil.isEmpty(assetsGetx.followInfoModel.symbol) ? "USDT" : assetsGetx.followInfoModel.symbol}${')'}',
                      style: AppTextStyle.f_12_400.color999999,
                    ),
                    Text(
                            assetsGetx.followInfoModel.unPnl == 0
                                ? '0.00'
                                : NumberUtil.mConvert(assetsGetx.followInfoModel.unPnl,
                                    isEyeHide: true, isRate: null, count: 6),
                            style: AppTextStyle.f_16_600.color333333)
                        .paddingSymmetric(vertical: 4.w),
                    Text(
                        "≈${NumberUtil.mConvert(assetsGetx.followInfoModel.unPnl, isEyeHide: true, isRate: IsRateEnum.usdt, count: 2)}",
                        style: AppTextStyle.f_12_400.color999999),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: EdgeInsets.only(bottom: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.w),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFF5F5F5)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${LocaleKeys.assets50.tr} ${'('}${TextUtil.isEmpty(assetsGetx.followInfoModel.symbol) ? "USDT" : assetsGetx.followInfoModel.symbol}${')'}',
                      style: AppTextStyle.f_12_400.color999999,
                    ),
                    // Text(
                    //     '${LocaleKeys.assets50.tr} ${'('}${TextUtil.isEmpty(assetsGetx.followInfoModel.symbol) ? "USDT" : assetsGetx.followInfoModel.symbol}${')'}',
                    //     style: AppTextStyle.small_500.colorABABAB),

                    Text(
                            assetsGetx.followInfoModel.followBalance == 0
                                ? '0.00'
                                : NumberUtil.mConvert(assetsGetx.followInfoModel.followBalance,
                                    isEyeHide: true, isRate: null, count: 6),
                            style: AppTextStyle.f_16_600.color333333)
                        .paddingSymmetric(vertical: 4.w),

                    Text(
                        "≈${NumberUtil.mConvert(assetsGetx.followInfoModel.followBalance, isEyeHide: true, isRate: IsRateEnum.usdt, count: 2)}",
                        style: AppTextStyle.f_12_400.color999999),
                  ],
                ),
              ),
            ),
            9.horizontalSpace,
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.w),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFF5F5F5)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${LocaleKeys.other56.tr} ${'('}${TextUtil.isEmpty(assetsGetx.followInfoModel.symbol) ? "USDT" : assetsGetx.followInfoModel.symbol}${')'}',
                      style: AppTextStyle.f_12_400.color999999,
                    ),
                    Text(assetsGetx.followInfoModel.followGold == 0 ? '0.00' : assetsGetx.followInfoModel.followGold.toString(),
                            style: AppTextStyle.f_16_600.color333333)
                        .paddingSymmetric(vertical: 4.w),
                    Text(
                        "≈${NumberUtil.mConvert(assetsGetx.followInfoModel.followGold, isEyeHide: true, isRate: IsRateEnum.usdt)}",
                        style: AppTextStyle.f_12_400.color999999),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  buildKolTop(AssetsGetx assetsGetx) {
    return Column(children: [
      AssetsBalance(
        title: LocaleKeys.assets5.tr,
        balance: assetsGetx.traderInfoTotal.toString(),
        tabType: AssetsTabEnumn.follow,
      ),
      SizedBox(height: 2.h),
      AssetsProfit(
          valueNum: assetsGetx.traderInfoModel.todaypnl.toString(),
          title: LocaleKeys.assets12.tr,
          value: NumberUtil.mConvert(assetsGetx.traderInfoModel.todaypnl, isEyeHide: true, isRate: IsRateEnum.usdt, count: 2),
          isTitleDotted: true,
          hasPercent: false,
          onTap: () {
            UIUtil.showAlert(LocaleKeys.assets12.tr, content: LocaleKeys.assets49.tr);
          }),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 16.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.w),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFF5F5F5)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${LocaleKeys.assets48.tr} ${'('}${TextUtil.isEmpty(assetsGetx.traderInfoModel.symbol) ? "USDT" : assetsGetx.traderInfoModel.symbol}${')'}',
                      style: AppTextStyle.f_12_400.color999999,
                    ),

                    // Text(
                    //     '${LocaleKeys.assets48.tr} ${'('}${TextUtil.isEmpty(assetsGetx.traderInfoModel.symbol) ? "USDT" : assetsGetx.traderInfoModel.symbol}${')'}',
                    //     style: AppTextStyle.small_500.colorABABAB),
                    Text(NumberUtil.mConvert(assetsGetx.traderInfoModel.followBalance, isEyeHide: true, isRate: null, count: 6),
                            style: AppTextStyle.f_16_600.color333333)
                        .paddingSymmetric(vertical: 4.w),

                    Text(
                        "≈${NumberUtil.mConvert(assetsGetx.traderInfoModel.followBalance, isEyeHide: true, isRate: IsRateEnum.usdt, count: 2)}",
                        style: AppTextStyle.f_12_400.color999999),
                  ],
                ),
              ),
            ),
            9.horizontalSpace,
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.w),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 1, color: Color(0xFFF5F5F5)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${LocaleKeys.assets51.tr} ${'('}${TextUtil.isEmpty(assetsGetx.traderInfoModel.symbol) ? "USDT" : assetsGetx.traderInfoModel.symbol}${')'}',
                      style: AppTextStyle.f_12_400.color999999,
                    ),
                    // Text(
                    //     '${LocaleKeys.assets51.tr} ${'('}${TextUtil.isEmpty(assetsGetx.traderInfoModel.symbol) ? "USDT" : assetsGetx.traderInfoModel.symbol}${')'}',
                    //     style: AppTextStyle.small_500.colorABABAB),

                    Text(NumberUtil.mConvert(assetsGetx.traderInfoModel.waitProfit, isEyeHide: true, isRate: null),
                            style: AppTextStyle.f_16_600.color333333)
                        .paddingSymmetric(vertical: 4.w),

                    Text(
                        "≈${NumberUtil.mConvert(assetsGetx.traderInfoModel.waitProfit, isEyeHide: true, isRate: IsRateEnum.usdt)}",
                        style: AppTextStyle.f_12_400.color999999),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }
}
