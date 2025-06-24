import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/getX/assets_Getx.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/assets/assets_spots.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_spots_info/controllers/assets_spots_info_controller.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_spots_info/model/asset_trade_model.dart';
import 'package:nt_app_flutter/app/modules/assets/assets_spots_info/widget/history_tabbar.dart';
import 'package:nt_app_flutter/app/modules/search/search/model/search_enum.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/utils/utilities/contract_util.dart';
import 'package:nt_app_flutter/app/utils/utilities/ui_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_button.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/app/widgets/components/activity_widget.dart';
import 'package:nt_app_flutter/app/widgets/components/assets/assets_balance.dart';
import 'package:nt_app_flutter/app/widgets/no/no_data.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../../widgets/no/network_error_widget.dart';

class AssetsSpotsHistoryView extends GetView<AssetsSpotsHistoryController> {
  const AssetsSpotsHistoryView({super.key});
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
              MyImage(
                controller.data.icon ?? '',
                width: 20.w,
              ),
              SizedBox(width: 4.w),
              Text(
                controller.data.coinName ?? '',
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
                      children: <Widget>[
                        _buildHeader(context, assetsGetx),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildTransaction(context),
                              _buildAD(context, assetsGetx),
                              _buildTabs(context),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SliverPinnedHeader(
                    child: HistoryTabbar(
                      dataArray: controller.tabList,
                      controller: controller.tabController,
                      height: 26,
                      radius: 22,
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
                          border: Border.all(color: AppColor.color111111),
                          backgroundColor: Colors.transparent,
                          onTap: () async {
                            if (controller.data.withdrawOpen == 1) {
                                Get.toNamed(Routes.ASSETS_WITHDRAWAL,
                                    arguments: controller.data.coinName);
                            } else {
                              UIUtil.showError(LocaleKeys.assets68.tr);
                            }
                          })),
                  SizedBox(width: 8.w),
                  Expanded(
                      child: MyButton(
                          height: 48.h,
                          text: LocaleKeys.assets35.tr,
                          color: Colors.white,
                          backgroundColor: AppColor.color111111,
                          onTap: () {
                            if (controller.data.depositOpen == 1) {
                              Get.toNamed(Routes.ASSETS_DEPOSIT,
                                  arguments: controller.data.coinName);
                            } else {
                              UIUtil.showError(LocaleKeys.assets69.tr);
                            }
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
    final AssetSpotsAllCoinMapModel data =
        assetsGetx.assetSpotsList[controller.spotsIndex];
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColor.colorEEEEEE))),
      child: Column(
        children: [
          AssetsBalance(
            title: LocaleKeys.assets70.tr,
            balance: data.usdtValuatin ?? '',
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
                    NumberUtil.mConvert(data.normalBalance),
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
                    NumberUtil.mConvert(data.lockBalance),
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

  Widget _buildTransaction(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              List<SearchResultsType> argumentTabs = <SearchResultsType>[
                SearchResultsType.contract,
                SearchResultsType.spot,
              ];
              Get.toNamed(Routes.SEARCH_INDEX, arguments: {
                'searchText': controller.data.coinName ?? '',
                'argumentTabs': argumentTabs
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  LocaleKeys.public17.tr,
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColor.color111111,
                      fontWeight: FontWeight.w600),
                ),
                MyImage(
                  'default/go'.svgAssets(),
                  color: AppColor.color111111,
                  width: 16.w,
                )
              ],
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Obx(() => Row(
                children: controller.recommendList.isEmpty
                    ? []
                    : controller.recommendList.map((trademodel) {
                        String showNameFirst = "";
                        String showNameLast = "";

                        String priceStr = "";
                        String roseStr = "";

                        if (trademodel.tradetype == 0) {
                          showNameFirst = trademodel.contractInfo!.base;
                          showNameLast = trademodel.contractInfo!.secondName;
                          priceStr = trademodel.contractInfo!.priceStr;
                          roseStr = trademodel.contractInfo!.roseStr;
                        } else if (trademodel.tradetype == 1) {
                          showNameFirst = trademodel.contractInfo!.base;
                          showNameLast = trademodel.contractInfo!.secondName;
                          priceStr = trademodel.contractInfo!.priceStr;
                          roseStr = trademodel.contractInfo!.roseStr;
                        } else if (trademodel.tradetype == 2) {
                          showNameFirst = trademodel.marketInfoModel!.firstName;
                          showNameLast = trademodel.marketInfoModel!.secondName;
                          priceStr = trademodel.marketInfoModel!.priceStr;
                          roseStr = trademodel.marketInfoModel!.roseStr;
                        }
                        return InkWell(
                          onTap: () async {
                            //todo 交易对跳转交易
                            Get.back();
                            _goToTrade(trademodel);
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                left: controller.recommendList
                                            .indexOf(trademodel) !=
                                        0
                                    ? 8.w
                                    : 0),
                            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0.h),
                            width: 108.w,
                            height: 98.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.r),
                                color: AppColor.colorF5F5F5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      showNameFirst,
                                      style: AppTextStyle.f_14_500.color111111,
                                    ),
                                    Text(
                                      showNameLast,
                                      style: AppTextStyle.f_11_500.colorABABAB,
                                    )
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                AutoSizeText(
                                  priceStr,
                                  maxLines: 1,
                                  minFontSize: 8,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      color: AppColor.color111111,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(height: 2.h),
                                AutoSizeText(
                                  roseStr,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: AppColor.upColor,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
              ))
        ],
      ),
    );
  }

  void _goToTrade(AssetsTradeModel trademodel) {
    goToTrade(trademodel.tradetype,
        contractInfo: trademodel.contractInfo,
        marketInfoModel: trademodel.marketInfoModel);
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
    return TabBarView(
        controller: controller.tabController,
        children: controller.dataList
            .map((element) => Obx(() => element.value.data == null
                ? !element.value.isInitial
                    ? Center(
                        child: Center(
                        child: NetworkErrorWidget(
                          onTap: () => controller.getListData(),
                        ),
                      ))
                    : const SizedBox()
                : element.value.data!.isEmpty
                    ? noDataWidget(context, text: LocaleKeys.public8.tr)
                    : SmartRefresher(
                        controller: controller.refreshController,
                        enablePullDown: false,
                        enablePullUp: true,
                        onLoading: () async {
                          if (element.value.haveMore) {
                            element.value.page++;
                            await controller.getListData();
                            controller.refreshController.loadComplete();
                          } else {
                            controller.refreshController.loadNoData();
                          }
                        },
                        child: ListView.builder(
                          itemBuilder: (BuildContext c, int i) {
                            if (element.value.data!.length == i) {
                              return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.h, horizontal: 16.w),
                                  child: Text(LocaleKeys.assets74.tr,
                                      style:
                                          AppTextStyle.f_11_400.colorBBBBBB));
                            } else {
                              var e = element.value.data![i];
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 20.h, horizontal: 16.w),
                                decoration: const BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: AppColor.colorEEEEEE))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          e.type,
                                          style:
                                              AppTextStyle.f_14_600.color111111,
                                        ),
                                        Text(
                                          e.value,
                                          style: TextStyle(
                                              fontSize: 16.sp,
                                              color: double.parse(e.value) > 0
                                                  ? AppColor.upColor
                                                  : AppColor.downColor,
                                              fontWeight: FontWeight.w700),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      e.time,
                                      style: AppTextStyle.f_13_400.color999999,
                                    )
                                  ],
                                ),
                              );
                            }
                          },
                          itemCount: element.value.data!.length + 1,
                        ),
                      ).marginOnly(
                        bottom: 90.w + MediaQuery.of(context).padding.bottom,
                      )))
            .toList());
  }
}
