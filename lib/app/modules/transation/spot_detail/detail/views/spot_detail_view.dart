import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_detail/detail/widgets/bottom_bar_widget.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_detail/price/views/spot_price_view.dart';
import 'package:nt_app_flutter/app/modules/transation/spot_goods/controllers/spot_goods_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/widgets/price/widgets/coin_detail_title.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/system_state_bar.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../../global/favorite/spot_favorite_controller.dart';
import '../../../../../widgets/basic/my_image.dart';
import '../../../../../widgets/basic/my_page_back.dart';
import '../../../../../widgets/basic/my_tab_underline_widget.dart';
import '../controllers/spot_detail_controller.dart';

class SpotDetailView extends GetView<SpotDetailController> {
  const SpotDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: MySystemStateBar(
        child: SafeArea(
          child: Screenshot(
            controller: controller.shotController,
            child: Scaffold(
              appBar: AppBar(
                leading: MyPageBackWidget(
                  onTap: () => Get.back(result: controller.marketInfo.value),
                ),
                title: Obx(
                  () => CoinDetailTitle(
                    title: controller.marketInfo.value?.showName ?? '--',
                    onTap: () {
                      controller.swapSpot();
                    },
                  ),
                ),
                centerTitle: false,
                titleSpacing: 0,
                actions: [
                  GetBuilder<SpotOptionController>(builder: (logic) {
                    bool isOption = logic
                        .isOption(controller.marketInfo.value?.symbol ?? '');
                    return MyImage(
                      isOption
                          ? 'assets/images/contract/detail_star_sel.svg'
                          : 'assets/images/contract/detail_star.svg',
                      width: isOption ? 20.w : 18.w,
                      onTap: () {
                        if (controller.marketInfo.value != null) {
                          SpotOptionController.to.updateSpotOption(
                              [controller.marketInfo.value!.symbol]);
                        }
                      },
                    );
                  }),
                  16.horizontalSpace,
                  InkWell(
                    onTap: controller.onShare,
                    child: MyImage(
                      'assets/images/contract/share.svg',
                      width: 18.w,
                    ),
                  ),
                  16.horizontalSpace,
                ],
              ),
              body: Column(
                children: [
                  _buildTab(),
                  const Expanded(
                    child: TabBarView(
                      children: [
                        SpotPriceView(),
                      ],
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: BottomBarWidget(
                contractInfo: null,
                marketInfo: controller.marketInfo.value,
                onTapTrade: () {
                  if (controller.marketInfo.value != null) {
                    SpotGoodsController.to
                        .changeMarketInfo(controller.marketInfo.value!);
                    Get.back();
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildTab() {
    return Container(
      height: 43.h,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: AppColor.colorF5F5F5,
            width: 1.w,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TabBar(
              isScrollable: true,
              indicator: MyUnderlineTabIndicator(
                borderSide: const BorderSide(
                  width: 2,
                  color: AppColor.color111111,
                ),
                lineWidth: 24.w,
              ),
              labelColor: AppColor.color111111,
              unselectedLabelColor: AppColor.colorABABAB,
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              tabs: [
                Tab(text: LocaleKeys.trade34.tr),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
