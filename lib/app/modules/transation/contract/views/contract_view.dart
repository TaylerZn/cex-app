import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/global/dataStore/contract_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info.dart';
import 'package:nt_app_flutter/app/modules/follow/follow_orders/zone/follow_orders_load.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/widgets/coin_transaction_config_widget.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/widgets/contract_operate_view.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/widgets/kchart/contract_bottom_kchart.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_asset/contract_asset_view.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_entrust/views/current_entrust_view.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_postion/views/contract_postion_view.dart';
import 'package:nt_app_flutter/app/modules/transation/widgets/trade_notify_widget.dart';
import 'package:nt_app_flutter/app/routes/app_pages.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_tab_underline_widget.dart';
import 'package:nt_app_flutter/app/widgets/components/guide/guide_index_view.dart';
import 'package:nt_app_flutter/app/widgets/components/keep_alive_wrapper.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:pull_to_refresh_notification/pull_to_refresh_notification.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../widgets/components/transaction/bottom_sheet/more_option_bottom_sheet.dart';
import '../../contract_entrust/controllers/contract_entrust_controller.dart';
import '../../contract_postion/controllers/contract_position_controller.dart';
import '../../swap_contract/views/swap_contract_bottom_sheet.dart';
import '../controllers/contract_controller.dart';

class ContractView extends GetView<ContractController> {
  const ContractView({super.key});

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('ContractView'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction == 1) {
          controller.showGuideView();
          controller.checkContractListIfEmptyLoadData();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body:  PullToRefreshNotification(
            onRefresh: () async {
              await controller.refreshData();
              return true;
            },
            maxDragOffset: 100,
            child: ExtendedNestedScrollView(
              controller: controller.scrollController,
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  PullToRefreshContainer((PullToRefreshScrollNotificationInfo? info) {
                    return SliverToBoxAdapter(
                      child: PullToRefreshHeader(info),
                    );
                  }),
                  const SliverToBoxAdapter(child: TradeNotifyWidget()),
                  SliverPinnedHeader(
                    child: Obx(() {
                      return GetBuilder<ContractDataStoreController>(
                          id: controller.currentContractInfo.value?.subSymbol ?? '',
                          builder: (logic) {
                            ContractInfo? contractInfo =
                                logic.getContractInfoBySubSymbol(controller.currentContractInfo.value?.subSymbol ?? '');
                            return CurrentTradeWidget(
                              title: controller.currentContractInfo.value?.symbol.formatSymbol('/') ?? '--/--',
                              change: contractInfo?.rose.toNum() ?? 0,
                              onChangeTrade: () async {
                                final res = await SwapContractBottomSheet.show();
                                if (res != null) {
                                  controller.changeContractInfo(res);
                                }
                              },
                              guideType: AppGuideType.perpetualContract,
                              onKchartTap: () async {
                                if (controller.currentContractInfo.value != null) {
                                  final res = await Get.toNamed(Routes.CONTRACT_DETAIL,
                                      arguments: controller.currentContractInfo.value);
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
                                      'to': 2,
                                    });
                                  },
                                  contractInfo: controller.currentContractInfo.value,
                                  onTradeRule: () {},
                                );
                              },
                            );
                          });
                    }),
                  ),
                  const SliverToBoxAdapter(child: ContractOperateView()),
                  SliverPinnedHeader(child: _buildTabBar(context.theme)),
                ];
              },
              body: TabBarView(
                controller: controller.tabController,
                children: const [
                  KeepAliveWrapper(child: ContractPositionView()),
                  KeepAliveWrapper(child: CurrentEntrustView()),
                  KeepAliveWrapper(child: ContractAssetView()),
                ],
              ),
            ),
          ),
        bottomNavigationBar: const ContractBottomKchart(),
      ),
    );
  }

  Widget _buildTabBar(ThemeData themeData) {
    return Container(
      height: 36.h,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 12.w),
      decoration: BoxDecoration(
        color: themeData.scaffoldBackgroundColor,
        border: const Border(
          bottom: BorderSide(
            color: AppColor.colorBorderGutter,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          AppGuideView(
            order: 5,
            guideType: AppGuideType.perpetualContract,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            arrowPosition: AppGuideArrowPosition.top,
            child: TabBar(
              controller: controller.tabController,
              isScrollable: true,
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
                  return Tab(text: '${LocaleKeys.trade13.tr}(${ContractPositionController.to.count.value})');
                }),
                Obx(() {
                  return Tab(text: '${LocaleKeys.trade12.tr}(${ContractEntrustController.to.count.value})');
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
              Get.toNamed(Routes.ENTRUST);
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
