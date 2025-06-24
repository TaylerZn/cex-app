import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/assets.dart';
import 'package:nt_app_flutter/app/enums/public.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_spots/controllers/assets_spots_controller.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_spots/views/asset_search_textField.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_spots/views/asset_view.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/components/assets/assets_action.dart';
import 'package:nt_app_flutter/app/widgets/components/assets/assets_balance.dart';
import 'package:nt_app_flutter/app/widgets/components/assets/assets_profit.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AssetsSpotsView extends GetView<AssetsSpotsController> {
  const AssetsSpotsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(AssetsSpotsController());
    return MySystemStateBar(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: GetBuilder<AssetsGetx>(builder: (assetsGetx) {
              return Container(
                  width: double.maxFinite,
                  height: double.maxFinite,
                  // padding: EdgeInsets.fromLTRB(16.w, 15.w, 16.w, 24.h),
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(13.r),
                          topRight: Radius.circular(13.r))),
                  child: SmartRefresher(
                    controller: controller.refreshController,
                    enablePullDown: true,
                    enablePullUp: false,
                    onRefresh: () async {
                      await Future.wait([assetsGetx.getRefresh()]);
                      controller.refreshController.refreshToIdle();
                      controller.refreshController.loadComplete();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          9.verticalSpaceFromWidth,
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AssetsBalance(
                                    titleStyle:
                                        AppTextStyle.f_12_400.color4D4D4D,
                                    title: LocaleKeys.assets5.tr,
                                    balance: assetsGetx.spotBalance,
                                    tabType: AssetsTabEnumn.spots,
                                    newStyle: true,
                                  ),
                                  AssetsProfit(
                                      titleStyle:
                                          AppTextStyle.f_11_400.color999999,
                                      valueNum:
                                          assetsGetx.pnlSpotAmount, //这里新增一个现货资产
                                      title: LocaleKeys.assets12.tr,
                                      value: NumberUtil.mConvert(
                                          assetsGetx.pnlSpotAmount, //这里新增一个现货资产
                                          isEyeHide: true,
                                          isRate: IsRateEnum.usdt,
                                          count: 2),
                                      percent:
                                          assetsGetx.pnlSpotRate, //这里新增一个现货资产
                                      isTitleDotted: true,
                                      onTap: () {
                                        UIUtil.showAlert(LocaleKeys.assets12.tr,
                                            content: LocaleKeys.assets62.tr);
                                      }),
                                  16.verticalSpaceFromWidth,
                                  AssetsAction(
                                      newStyle: true,
                                      height: 36.h,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(60.r)),
                                      list: controller.actions,
                                      onTap: controller.actionHandler),
                                  16.verticalSpaceFromWidth,
                                  Text(
                                    LocaleKeys.public19.tr,
                                    style: AppTextStyle.f_14_600.color111111,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          assetsGetx.setHideZeroOpen();
                                          assetsGetx.getRefresh();
                                          Get.back();
                                        },
                                        child: Row(
                                          children: [
                                            MyImage(
                                              assetsGetx.isHideZero
                                                  ? 'assets/check'.pngAssets()
                                                  : 'assets/not_check'
                                                      .svgAssets(),
                                              width: 12.w,
                                              height: 12.w,
                                            ).marginOnly(right: 4.w),
                                            Container(
                                              alignment: Alignment.center,
                                              height: 40.h,
                                              child: Text(
                                                  LocaleKeys.assets61.tr,
                                                  style: AppTextStyle
                                                      .f_11_400.color4D4D4D),
                                            )
                                          ],
                                        ),
                                      ),
                                      SearchTextField(
                                        newStyle: true,
                                        controller: controller.textEditSearch,
                                        height: 25.w,
                                        hintText: LocaleKeys.assets63.tr,
                                        onChanged: (keyword) {
                                          assetsGetx.setSearchKeyword(keyword);
                                          assetsGetx.getRefresh();
                                        },
                                      )
                                    ],
                                  ),
                                ],
                              )),
                          AssetView(
                            list: assetsGetx.assetSpotsList,
                            keyword: assetsGetx.searchKeyword,
                            hideZero: assetsGetx.isHideZero,
                          )
                        ],
                      ),
                    ),
                  ));
            })));
  }
}
