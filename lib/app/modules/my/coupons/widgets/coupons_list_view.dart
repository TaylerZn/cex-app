import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/global/dataStore/commodity_data_store_controller.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_main/controllers/assets_main_controller.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/model/follow_kol_model.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/main_tab/controllers/main_tab_controller.dart';
import 'package:nt_app_flutter/app/modules/my/coupons/controllers/coupons_index_controller.dart';
import 'package:nt_app_flutter/app/modules/my/coupons/model/coupons_model.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/getx_extension.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../utils/utilities/contract_util.dart';

class CouponsListView extends StatelessWidget {
  const CouponsListView({
    super.key,
    required this.controller,
    required this.type,
  });

  final CouponsIndexController controller;
  final CouponsType type;
  @override
  Widget build(BuildContext context) {
    var refreshVc = type == CouponsType.claimed ? controller.refreshVcArr.first : controller.refreshVcArr.last;
    return SmartRefresher(
      controller: refreshVc,
      enablePullDown: true,
      enablePullUp: false,
      onRefresh: () async {
        await controller.getData(isPullDown: true);
        refreshVc.refreshToIdle();
        refreshVc.loadComplete();
      },
      child: CustomScrollView(slivers: [
        Obx(() => controller.dataArray[type.index].value.cardList?.isNotEmpty == true
            ? SliverList.builder(
                itemCount: controller.dataArray[type.index].value.cardList!.length,
                itemBuilder: (context, index) {
                  var model = controller.dataArray[type.index].value.cardList![index];
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 0.w),
                      child: Stack(
                        clipBehavior: Clip.hardEdge,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 16.w),
                            decoration: const BoxDecoration(
                                // color: Colors.amber,
                                image: DecorationImage(
                                    image: AssetImage('assets/images/default/coupons_bg.png'), fit: BoxFit.fill)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 112.w,
                                  // color: Colors.amber,
                                  padding: EdgeInsets.only(top: 19.h, left: 15.w, right: 15.w),

                                  child: Column(
                                    children: <Widget>[
                                      Text(model.coinSymbolStr, style: AppTextStyle.f_12_500.color4D4D4D),
                                      AutoSizeText(model.tokenNumStr,
                                          maxLines: 1, minFontSize: 4, style: AppTextStyle.f_38_600.color111111),
                                      model.statusStr.isEmpty
                                          ? MyButton(
                                              text: model.btnText,
                                              backgroundColor:
                                                  model.btnEnabled ? const Color(0xFFFFD428) : AppColor.colorCCCCCC,
                                              color: AppColor.color111111,
                                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.w),
                                              textStyle: AppTextStyle.f_10_500,
                                              onTap: () {
                                                if (model.isBonus) {
                                                  if (model.expStatus == 1) {
                                                    //未领取
                                                    controller.getReceiveExpCoupon(model.cardSn, (str) {
                                                      showView(model, str);
                                                    });
                                                  }
                                                  // else if (model.expStatus == 0) {
                                                  //   //已领取未使用
                                                  //   pushView(model);
                                                  // }
                                                } else {
                                                  if (model.status == 0) {
                                                    var isStandardContract = model.isStandardContract; //true 为标准合约  false 为永续合约
                                                    var name = model.coinName;
                                                    ContractInfo? contractInfo;
                                                    if (isStandardContract) {
                                                      contractInfo =
                                                          CommodityDataStoreController.to.getContractInfoBySubSymbol(name);
                                                    } else {
                                                      contractInfo =
                                                          ContractDataStoreController.to.getContractInfoBySubSymbol(name);
                                                    }
                                                    goToTrade(
                                                      isStandardContract ? 0 : 1,
                                                      contractInfo: contractInfo,
                                                    );
                                                  }
                                                }
                                              },
                                            )
                                          : const SizedBox()
                                    ],
                                  ),
                                ),
                                model.isBonus
                                    ? Container(
                                        width: 231.w,
                                        // color: Colors.amber,
                                        padding: EdgeInsets.fromLTRB(24.w, 16.h, 16.w, 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(LocaleKeys.other56.tr, style: AppTextStyle.f_14_600.color111111),
                                            Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                                                margin: EdgeInsets.only(top: 6.w, bottom: 8.w),
                                                decoration: ShapeDecoration(
                                                  color: AppColor.colorF1F1F1,
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                                                ),
                                                child: Text(model.contractTypeStr, style: AppTextStyle.f_10_500.color4D4D4D)),
                                            Text(model.expireStr, style: AppTextStyle.small4_400.color999999),
                                            model.cardType == 2 && model.followName.isNotEmpty
                                                ? Text.rich(
                                                    TextSpan(
                                                      children: [
                                                        TextSpan(
                                                            text: '${LocaleKeys.other59.tr}:',
                                                            style: AppTextStyle.small4_400.color999999),
                                                        TextSpan(
                                                            text: model.followName, style: AppTextStyle.small4_400.tradingYel),
                                                      ],
                                                    ),
                                                  )
                                                : const SizedBox(),
                                            Container(
                                                margin: EdgeInsets.only(top: 4.w, bottom: 9.w),
                                                height: 0.5,
                                                color: AppColor.colorECECEC),
                                            GestureDetector(
                                              onTap: () {
                                                UIUtil.showAlert(LocaleKeys.other60.tr,
                                                    content: LocaleKeys.other61.tr, confirmText: LocaleKeys.public57.tr);
                                              },
                                              child: Text(LocaleKeys.other58.tr,
                                                      style: AppTextStyle.small3_400.copyWith(color: AppColor.colorAbnormal))
                                                  .marginOnly(bottom: 10.h),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(
                                        width: 231.w,
                                        // color: Colors.orange,
                                        padding: EdgeInsets.fromLTRB(24.w, 16.h, 16.w, 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(model.contractTypeStr, style: AppTextStyle.f_14_600.color111111),
                                            // Text(LocaleKeys.user270.trArgs([model.maxLeverageStr, model.conditionNumStr]),
                                            //         style: AppTextStyle.small_400_150.color111111)

                                            Text(LocaleKeys.user270.trArgs([model.maxLeverageStr, model.conditionNumStr]),
                                                    style: AppTextStyle.small_400_150.color111111)
                                                .paddingSymmetric(vertical: 4.h),
                                            GestureDetector(
                                              onTap: () {
                                                UIUtil.showAlert(LocaleKeys.user294.tr,
                                                    content: '${LocaleKeys.user295.tr}${model.contractNameStr}',
                                                    confirmText: LocaleKeys.public57.tr);
                                              },
                                              child: Text(LocaleKeys.user269.tr,
                                                      style: AppTextStyle.small3_400.copyWith(color: AppColor.colorAbnormal))
                                                  .marginOnly(bottom: 10.h),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(model.expireStr, style: AppTextStyle.small4_400.color666666),
                                                // GestureDetector(
                                                //   onTap: () {},
                                                //   child: Container(
                                                //     color: AppColor.colorWhite,
                                                //     padding: EdgeInsets.all(3.w),
                                                //     child: MyImage(
                                                //       'default/coupons_more'.svgAssets(),
                                                //       width: 7.w,
                                                //     ),
                                                //   ),
                                                // )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                              ],
                            ),
                          ),
                          model.statusStr.isNotEmpty
                              ? Positioned(
                                  top: -24.h,
                                  right: -54.w,
                                  child: Transform(
                                    transform: Matrix4.identity()
                                      ..translate(0.0, 0.0)
                                      ..rotateZ(0.8),
                                    child: Container(
                                        width: 100.w,
                                        height: 22.h,
                                        alignment: Alignment.center,
                                        color: AppColor.colorBBBBBB,
                                        child: Text(model.statusStr, style: AppTextStyle.small3_500.colorWhite)),
                                  ))
                              : const SizedBox()
                        ],
                      ),
                    ),
                  );
                },
              )
            : FollowOrdersLoading(
                isError: controller.dataArray[type.index].value.isError,
                onTap: () {
                  controller.getData();
                }))
      ]),
    );
  }

  showView(CouponsModel model, String str) {
    showModalBottomSheet(
      // backgroundColor: Colors.red,
      context: Get.context!,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (BuildContext context) {
        return Container(
            decoration: const BoxDecoration(
              color: AppColor.colorWhite,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            padding: EdgeInsets.only(top: 40.w, bottom: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: 84.w,
                  height: 84.w,
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.4), borderRadius: BorderRadius.circular(32.w)),
                  child: ClipOval(
                    child: MyImage(
                      'assets/images/my/setting/kyc_ok.png',
                    ),
                  ),
                ),
                Text(LocaleKeys.other50.tr, style: AppTextStyle.h5_500.color111111).paddingOnly(top: 24.w, bottom: 20.w),
                Text(
                  '${LocaleKeys.other51.tr}【${model.contractTypeStr}】。${LocaleKeys.other52.tr}:$str。'.tr,
                  style: AppTextStyle.small_400_150.color999999,
                  textAlign: TextAlign.center,
                ).paddingSymmetric(horizontal: 16.w),
                Container(height: 1, color: AppColor.colorECECEC, margin: EdgeInsets.only(top: 24.w, bottom: 16.w)),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: MyButton.borderWhiteBg(
                        height: 48.w,
                        text: LocaleKeys.other53.tr,
                        onTap: () {
                          if (model.cardType == 2) {
                            AssetsMainController.navigateToFlow();
                          } else {
                            AssetsMainController.navigateToContract();
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 12.h),
                    Expanded(
                        child: MyButton(
                      height: 48.w,
                      text: LocaleKeys.other54.tr,
                      onTap: () {
                        pushView(model);
                      },
                    )),
                  ],
                ).paddingSymmetric(horizontal: 16.w),
                SizedBox(height: MediaQuery.of(context).padding.bottom)
              ],
            ));
      },
    );
  }

  pushView(CouponsModel model) {
    if (model.cardType == 2) {
      // var uid = model.followId.isEmpty
      //     ? (UserGetx.to.user?.info?.id ?? 0)
      //     : (num.tryParse(model.followId) ?? (UserGetx.to.user?.info?.id ?? 0));
      // Get.back();
      // Get.toNamed(Routes.FOLLOW_TAKER_INFO, arguments: {'model': FollowKolInfo(uid: uid)});

      Get.untilNamed(Routes.MAIN_TAB);
      MainTabController.to.changeTabIndex(3);
    } else {
      var isStandardContract = model.isStandardContract; //true 为标准合约  false 为永续合约
      var name = model.coinName;
      ContractInfo? contractInfo;
      if (isStandardContract) {
        contractInfo = CommodityDataStoreController.to.getContractInfoBySubSymbol(name);
      } else {
        contractInfo = ContractDataStoreController.to.getContractInfoBySubSymbol(name);
      }
      goToTrade(
        isStandardContract ? 0 : 1,
        contractInfo: contractInfo,
      );
    }
  }
}
