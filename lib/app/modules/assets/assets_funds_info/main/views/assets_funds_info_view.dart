import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/assets/assets_funds.dart';
import 'package:nt_app_flutter/app/models/assets/assets_spots.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_funds_info/history/views/info_history_view.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_funds_info/main/widget/history_tabbar.dart';
import 'package:nt_app_flutter/app/modules/community/video_editor_set_cover_page.dart';
import 'package:nt_app_flutter/app/modules/markets/market/widgets/market_list_icon.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/components/assets/assets_balance.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';
import 'package:nt_app_flutter/app/widgets/no/no_data.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/widgets/components/activity_widget.dart';

import '../controllers/assets_funds_info_controller.dart';

class AssetsFundsInfoView extends GetView<AssetsFundsInfoController> {
  const AssetsFundsInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssetsGetx>(builder: (assetsGetx) {
      return Scaffold(
        appBar: AppBar(
          leading: const MyPageBackWidget(),
          title: Row(
            mainAxisSize: MainAxisSize.min, // 限制Row的大小仅包裹其子Widget
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MarketIcon(
                iconName: controller.data.coinSymbol ?? '',
                width: 24.w,
              ),
              SizedBox(width: 4.w),
              Text(
                controller.data.coinSymbol ?? '',
                style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColor.color111111,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: Stack(children: [
          NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildHeader(context, assetsGetx),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildAD(context, assetsGetx),
                              _buildTabs(context),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SliverPinnedHeader(
                    child: AssetsFundsInfoTabbar(
                      dataArray: controller.tabList,
                      controller: controller.tabController,
                      height: 26.h,
                      radius: 22.r,
                    ),
                  )
                ];
              },
              body: _buildList(context)),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                  color: AppColor.colorWhite,
                  border: Border(top: BorderSide(color: AppColor.colorEEEEEE))),
              height: 80.w + MediaQuery.of(context).padding.bottom,
              padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w,
                  16.h + MediaQuery.of(context).padding.bottom),
              child: Row(
                children: [
                  Expanded(
                    child: MyButton(
                      height: 48.h,
                      text: LocaleKeys.assets64.tr,
                      color: AppColor.color111111,
                      border: Border.all(color: AppColor.colorABABAB),
                      backgroundColor: Colors.transparent,
                      onTap: () async {
                          Get.toNamed(Routes.ASSETS_WITHDRAWAL,
                              arguments: controller.data.coinSymbol);
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                      child: MyButton(
                          height: 48.h,
                          text: LocaleKeys.assets35.tr,
                          color: Colors.white,
                          backgroundColor: AppColor.color111111,
                          onTap: () {
                            Get.toNamed(Routes.ASSETS_DEPOSIT,
                                arguments: controller.data.coinSymbol);
                          }))
                ],
              ),
            ),
          )
        ]),
      );
    });
  }

  Widget _buildHeader(BuildContext context, AssetsGetx assetsGetx) {
    final AssetsFundsAllCoinMapModel data =
        assetsGetx.assetFundsList[controller.fundsIndex];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColor.colorEEEEEE))),
      child: Column(
        children: [
          AssetsBalance(
            title: LocaleKeys.assets147.tr,
            balance: data.totalBalance ?? '',
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.assets48.tr,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColor.colorABABAB,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    NumberUtil.mConvert(data.normal),
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColor.color111111,
                        fontWeight: FontWeight.w500),
                  )
                ],
              )),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.assets71.tr,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColor.colorABABAB,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    NumberUtil.mConvert(data.lock),
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColor.color111111,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ))
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAD(BuildContext context, AssetsGetx assetsGetx) {
    return Obx(() => Visibility(
          visible: controller.aDlist.value.isNotEmpty,
          child: MyActivityWidget(
            list: controller.aDlist.value,
            height: 72.h,
          ),
        ));
  }

  Widget _buildTabs(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.assets73.tr,
              style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColor.color111111,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 14.h),
          ],
        ));
  }

  Widget _buildList(BuildContext context) {
    // return Container();
    return TabBarView(
        controller: controller.tabController,
        children: controller.tabList
            .map((element) => KeepAliveWrapper(
                    child: AssetsFundsInfoHistoryView(
                  source: element.source,
                  coinSymbol: controller.data.coinSymbol,
                )))
            .toList());
  }
}
