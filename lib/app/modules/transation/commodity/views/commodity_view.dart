import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/transation/commdity_asset/commodity_asset_view.dart';
import 'package:nt_app_flutter/app/modules/transation/widgets/trade_notify_widget.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/components/transaction/bottom_sheet/more_option_bottom_sheet.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../config/theme/app_text_style.dart';
import '../../../../global/dataStore/commodity_data_store_controller.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/basic/my_image.dart';
import '../../../../widgets/basic/my_tab_underline_widget.dart';
import '../../../../widgets/components/guide/guide_index_view.dart';
import '../../../../widgets/components/keep_alive_wrapper.dart';
import '../../commodity_position/controllers/commodity_position_controller.dart';
import '../../commodity_position/views/commodity_position_view.dart';
import '../../commodiy_entrust/controllers/commondiy_entrust_controller.dart';
import '../../commodiy_entrust/views/commondiy_entrust_view.dart';
import '../../contract/widgets/coin_transaction_config_widget.dart';
import '../../swap_commondity/views/swap_commodity_bottom_sheet.dart';
import '../controllers/commodity_controller.dart';
import '../widgets/commodity_operate_view.dart';

class CommodityView extends GetView<CommodityController> {
  const CommodityView({super.key});

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('CommodityView'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction == 1) {
          controller.showGuideView();
          controller.checkContractListIfEmptyLoadData();
          controller.isGuiding.value =
              AppGuideView.canShowButtonGuide(AppGuideType.standardContract);
          /// 刷新可用余额
          CommodityPositionController.to.fetchData();
        }
      },
      child:  PullToRefreshNotification(
          onRefresh: () async {
            await controller.refreshData();
            return true;
          },
          maxDragOffset: 100,
          child: ExtendedNestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                PullToRefreshContainer((PullToRefreshScrollNotificationInfo? info) {
                  return SliverToBoxAdapter(
                    child: PullToRefreshHeader(info),
                  );
                }),
                const SliverToBoxAdapter(
                  child: TradeNotifyWidget(),
                ),
                SliverPinnedHeader(
                  child: Obx(() {
                    return GetBuilder<CommodityDataStoreController>(
                        id: controller.state.contractInfo.value?.subSymbol ?? '',
                        builder: (logic) {
                          ContractInfo? contractInfo =
                              logic.getContractInfoBySubSymbol(controller.state.contractInfo.value?.subSymbol ?? '');
                          return CurrentTradeWidget(
                            title: '${contractInfo?.firstName ?? '-'}${contractInfo?.secondName ?? '-'}',
                            change: contractInfo?.rose.toNum() ?? 0,
                            onChangeTrade: () async {
                              final res = await SwapCommodityBottomSheet.show();
                              if (res != null) {
                                controller.changeContractInfo(res);
                              }
                            },
                            guideType: AppGuideType.standardContract,
                            onKchartTap: () async {
                              if (controller.state.contractInfo.value != null) {
                                final res = await Get.toNamed(
                                  Routes.COMMONDITY_DETAIL,
                                  arguments: controller.state.contractInfo.value,
                                );
                                if (res != null) {
                                  controller.changeContractInfo(res);
                                }
                              }
                            },
                            onMoreTap: () {
                              MoreOptionBottomSheet.show(
                                onTransfer: () {
                                  Get.toNamed(Routes.ASSETS_TRANSFER, arguments: {
                                    'from': 3,
                                    'to': 1,
                                  });
                                },
                                contractInfo: controller.state.contractInfo.value,
                                onTradeRule: () {},
                              );
                            },
                          );
                        });
                  }),
                ),
                const SliverToBoxAdapter(
                  child: CommodityOperateView(),
                ),
                SliverPinnedHeader(child: _buildTabBar(context.theme)),
              ];
            },
            body: TabBarView(
              controller: controller.tabController,
              children: const [
                KeepAliveWrapper(child: CommodityPositionView()),
                KeepAliveWrapper(child: CommodityEntrustView()),
                KeepAliveWrapper(child: CommodityAssetView()),
              ],
            ),
          ),
        ),
    );
  }

  Widget _buildTabBar(ThemeData themeData) {
    return Container(
      height: 38.h,
      padding: EdgeInsets.only(left: 12.w),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: themeData.scaffoldBackgroundColor,
        border: const Border(
          bottom: BorderSide(
            color: AppColor.colorF5F5F5,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          AppGuideView(
            order: 5,
            guideType: AppGuideType.standardContract,
            padding: EdgeInsets.zero,
            arrowPosition: AppGuideArrowPosition.top,
            finishCallback: () {
              controller.isGuiding.value = false;
            },
            child: TabBar(
              isScrollable: true,
              controller: controller.tabController,
              indicator: const MyUnderlineTabIndicator(
                borderSide: BorderSide(
                  width: 2,
                  color: AppColor.colorTextPrimary,
                ),
              ),
              labelColor: AppColor.colorTextPrimary,
              unselectedLabelColor: AppColor.colorTextDisabled,
              labelStyle: AppTextStyle.f_14_600,
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.only(right: 20.w),
              unselectedLabelStyle: AppTextStyle.f_14_600,
              tabs: [
                Obx(() {
                  return Tab(
                    text: '${LocaleKeys.trade13.tr}(${CommodityPositionController.to.count.value})',
                  );
                }),
                Obx(() {
                  return Tab(
                    text: '${LocaleKeys.trade12.tr}(${CommodityEntrustController.to.count.value})',
                  );
                }),
                Tab(
                  text: LocaleKeys.assets9.tr,
                ),
              ],
            ),
          ),
          const Spacer(),
          MyImage(
            'assets/images/contract/history_order.svg',
            width: 20.w,
            height: 20.w,
            onTap: () {
              if (UserGetx.to.goIsLogin()) {
                Get.toNamed(Routes.COMMODITY_HISTORY_MAIN, arguments: controller.state.contractInfo.value);
              }
            },
          ),
          SizedBox(
            width: 12.w,
          ),
        ],
      ),
    );
  }
}
