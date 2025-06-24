import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/enums/assets.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_funds/controllers/assets_funds_controller.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_funds/widgets/asset_view.dart';
import 'package:nt_app_flutter/app/modules/otc/c2c/utils/otc_config_utils.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/route_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/app/widgets/components/assets/assets_balance.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../assets_spots/views/asset_search_textField.dart';

class AssetsFundsView extends GetView<AssetsFundsController> {
  const AssetsFundsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AssetsFundsController());
    return MySystemStateBar(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetBuilder<AssetsGetx>(
          builder: (assetsGetx) {
            return Container(
                width: double.maxFinite,
                height: double.maxFinite,
                // padding: EdgeInsets.fromLTRB(16.w, 0.h, 16.w, 24.h),
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(13.r),
                    topRight: Radius.circular(13.r),
                  ),
                ),
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
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                12.verticalSpaceFromWidth,
                                AssetsBalance(
                                  title: LocaleKeys.assets5.tr,
                                  titleStyle: AppTextStyle.f_12_400.color4D4D4D,
                                  balance: assetsGetx.c2cBalance,
                                  tabType: AssetsTabEnumn.funds,
                                  newStyle: true,
                                ),
                                16.verticalSpaceFromWidth,
                                // TODO:暂时隐藏，后期扩展AssetsAction
                                // AssetsAction(list: controller.actions),
                                Row(
                                  children: [
                                    Expanded(
                                        child: MyButton(
                                      backgroundColor: AppColor.colorBlack,
                                      height: 36.h,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(60.r)),
                                      onTap: () => {RouteUtil.goTo('/otc-b2c')},
                                      child: Text(LocaleKeys.assets144.tr,
                                          style:
                                              AppTextStyle.f_14_600.colorWhite),
                                    )),
                                    OtcConfigUtils().haveC2C
                                        ? Expanded(
                                            child: MyButton(
                                            backgroundColor:
                                                AppColor.colorF5F5F5,
                                            height: 36.h,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(60.r)),
                                            onTap: () =>
                                                {RouteUtil.goTo('/otc-c2c')},
                                            child: Text(LocaleKeys.other35.tr,
                                                style: AppTextStyle
                                                    .f_14_600.color111111),
                                          ).marginOnly(left: 10.w))
                                        : const SizedBox(),
                                    Expanded(
                                        child: MyButton(
                                      backgroundColor: AppColor.colorF5F5F5,
                                      height: 36.h,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(60.r)),
                                      onTap: () async {
                                        try {
                                          final bool res = await Get.toNamed(
                                              Routes.ASSETS_TRANSFER,
                                              arguments: {"from": 3, "to": 4});
                                          if (res) {
                                            UIUtil.showSuccess(
                                                LocaleKeys.assets10.tr);
                                            AssetsGetx.to
                                                .getTotalAccountBalance();
                                          }
                                        } catch (e) {
                                          print(e);
                                        }
                                      },
                                      child: Text(LocaleKeys.assets7.tr,
                                          style: AppTextStyle
                                              .f_15_600.color111111),
                                    ).marginOnly(left: 10.w)),
                                  ],
                                ),
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
                                            child: Text(LocaleKeys.assets61.tr,
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
                                        assetsGetx
                                            .setSearchKeyword_Found(keyword);
                                        assetsGetx.getRefresh();
                                      },
                                    )
                                  ],
                                ),
                              ],
                            )),
                        FundsAssetView(
                          list: assetsGetx.assetFundsList,
                          keyword: assetsGetx.searchKeywordFound,
                          hideZero: assetsGetx.isHideZero,
                        )
                      ],
                    ),
                  ),
                ));
          },
        ),
      ),
    );
  }
}
