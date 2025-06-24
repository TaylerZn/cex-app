import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:nt_app_flutter/app/getX/user_Getx.dart';
import 'package:nt_app_flutter/app/global/dataStore/spot_data_store_controller.dart';
import 'package:nt_app_flutter/app/models/contract/res/public_info_market.dart';

import 'package:nt_app_flutter/app/modules/transation/spot_goods/controllers/spot_entrust_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_goods/views/spot_entrust_view.dart';
import 'package:nt_app_flutter/app/modules/transation/swap_spot/views/swap_spot_bottom_sheet.dart';
import 'package:nt_app_flutter/app/utils/extension/string_extension.dart';
import 'package:nt_app_flutter/app/widgets/components/guide/guide_index_view.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../config/theme/app_color.dart';
import '../../../../routes/app_pages.dart';
import '../../../../widgets/basic/my_image.dart';
import '../../../../widgets/basic/my_tab_underline_widget.dart';
import '../../../../widgets/basic/system_state_bar.dart';
import '../../../../widgets/components/transaction/bottom_sheet/more_option_bottom_sheet.dart';
import '../../contract/widgets/coin_transaction_config_widget.dart';
import '../controllers/spot_goods_controller.dart';
import '../widgets/sport_goods_operate_view.dart';
import 'asset_list_view.dart';

class SpotGoodsView extends GetView<SpotGoodsController> {
  const SpotGoodsView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return VisibilityDetector(
      key: const Key('SpotGoodsView'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction == 1) {
          controller.showGuideView();
        }
      },
      child: DefaultTabController(
          length: 2,
          child: MySystemStateBar(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: SafeArea(
                child: NestedScrollView(
                  headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverPinnedHeader(
                        child: Obx(() {
                          return GetBuilder<SpotDataStoreController>(
                              id: controller.marketInfo.value?.symbol ?? '',
                              builder: (logic) {
                                MarketInfoModel? marketInfo =
                                    logic.getMarketInfoBySymbol(controller.marketInfo.value?.symbol ?? '');
                                return CurrentTradeWidget(
                                  title: controller.marketInfo.value?.showName ?? 'BTC/USDT',
                                  change: marketInfo?.rose.toNum() ?? 0,
                                  onChangeTrade: () async {
                                    final res = await SwapSpotBottomSheet.show();
                                    if (res != null) {
                                      controller.changeMarketInfo(res);
                                    }
                                  },
                                  guideType: AppGuideType.spot,
                                  onKchartTap: () async {
                                    final res = await Get.toNamed(Routes.SPOT_DETAIL, arguments: controller.marketInfo.value);
                                    if (res != null) {
                                      controller.changeMarketInfo(res);
                                    }
                                  },
                                  onMoreTap: () {
                                    MoreOptionBottomSheet.show(
                                      onTransfer: () {
                                        Get.toNamed(Routes.ASSETS_TRANSFER, arguments: {
                                          'from': 0,
                                          'to': 3,
                                        });
                                      },
                                      marketInfoModel: controller.marketInfo.value,
                                      onTradeRule: () {
                                        // TDOO::
                                      },
                                    );
                                  },
                                );
                              });
                        }),
                      ),
                      const SliverToBoxAdapter(child: SpotGoodsOperateView()),
                      SliverPinnedHeader(child: _buildTabBar(context.theme)),
                    ];
                  },
                  body: const TabBarView(
                    children: [
                      SpotEntrustView(),
                      AssetListView(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }

  Widget _buildTabBar(ThemeData themeData) {
    return Container(
      height: 45.h,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: themeData.scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: AppColor.colorF5F5F5,
            width: 1.w,
          ),
        ),
      ),
      child: Row(
        children: [
          AppGuideView(
            order: 2,
            guideType: AppGuideType.spot,
            arrowPosition: AppGuideArrowPosition.top,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TabBar(
              isScrollable: true,
              indicator: MyUnderlineTabIndicator(
                borderSide: const BorderSide(
                  width: 2,
                  color: AppColor.color111111,
                ),
                lineWidth: 34.w,
              ),
              labelColor: AppColor.color111111,
              unselectedLabelColor: AppColor.colorABABAB,
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.only(right: 20.w),
              unselectedLabelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              tabs: [
                Obx(() {
                  return Tab(text: '${LocaleKeys.trade12.tr}(${SpotEntrustController.to.dataList.length})');
                }),
                Tab(text: LocaleKeys.trade120.tr),
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
                Get.toNamed(Routes.SPOT_HISTORY_MAIN);
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
