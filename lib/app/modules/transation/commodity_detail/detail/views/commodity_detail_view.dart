import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/global/favorite/commodity_favorite_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/commodity/widgets/close_market_button.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_detail/contract_info/views/contract_info_view.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_detail/detail/widgets/bottom_bar_widget.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../config/theme/app_text_style.dart';
import '../../../../../utils/utilities/contract_util.dart';
import '../../../../../utils/utilities/route_util.dart';
import '../../../../../widgets/basic/my_tab_underline_widget.dart';
import '../../../commodity/controllers/commodity_controller.dart';
import '../../../widgets/price/widgets/coin_detail_title.dart';
import '../../price/views/commodity_price_view.dart';
import '../controllers/commodity_detail_controller.dart';

class CommodityDetailView extends GetView<CommodityDetailController> {
  const CommodityDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Screenshot(
          controller: controller.shotController,
          child: Scaffold(
            appBar: AppBar(
              leading: MyPageBackWidget(
                onTap: () => Get.back(result: controller.contractInfo.value),
              ),
              title: Obx(
                () => CoinDetailTitle(
                  title:
                      '${controller.contractInfo.value?.firstName ?? '-'}${controller.contractInfo.value?.secondName ?? '-'}',
                  subTitle: controller.contractInfo.value?.getContractType,
                  onTap: () {
                    controller.swapContract();
                  },
                ),
              ),
              centerTitle: false,
              titleSpacing: 0,
              actions: [
                GetBuilder<CommodityOptionController>(builder: (logic) {
                  bool isOption =
                      logic.isOption(controller.contractInfo.value?.id ?? 0);
                  return MyImage(
                    isOption
                        ? 'assets/images/contract/detail_star_sel.svg'
                        : 'assets/images/contract/detail_star.svg',
                    width: isOption ? 20.w : 18.w,
                    onTap: () {
                      if (controller.contractInfo.value != null) {
                        CommodityOptionController.to.updateContractOption(
                            [controller.contractInfo.value!.id]);
                      }
                    },
                  );
                }),
                20.horizontalSpace,
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
                Expanded(
                  child: TabBarView(
                    children: [
                      const CommodityPriceView(),
                      Obx(() {
                        return ContractInfoView(
                          contractInfo: controller.contractInfo.value,
                          openTime: controller.openTime.value,
                          maxLevel: controller.maxLevel.value ?? 0,
                        );
                      })
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Obx(
              () {
                if ((controller.openStatus.value?.tradeOpen ?? true)) {
                  return BottomBarWidget(
                      contractInfo: controller.contractInfo.value,
                      onTapTrade: () {
                        if (controller.contractInfo.value != null) {
                          CommodityController.to.changeContractInfo(
                              controller.contractInfo.value!);
                          goToTrade(0,
                              contractInfo: controller.contractInfo.value);
                        }
                      });
                } else {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          color: AppColor.colorF5F5F5,
                          width: 1.w,
                        ),
                      ),
                    ),
                    child: CloseMarketButton(
                      endTime: controller
                              .openStatus.value?.nextOpenTimeIntervalMills ??
                          0,
                      stopCallback: controller.fetchOpenStatus,
                    ).marginSymmetric(horizontal: 16.w),
                  );
                }
              },
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
        border: const Border(
          bottom: BorderSide(
            color: AppColor.colorBorderGutter,
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          TabBar(
            isScrollable: true,
            indicator: const MyUnderlineTabIndicator(
              borderSide: BorderSide(
                width: 2,
                color: AppColor.colorTextPrimary,
              ),
            ),
            labelColor: AppColor.colorTextPrimary,
            unselectedLabelColor: AppColor.colorTextDisabled,
            labelStyle: AppTextStyle.f_14_500,
            unselectedLabelStyle: AppTextStyle.f_14_500,
            tabs: [
              Tab(text: LocaleKeys.trade34.tr),
              Tab(text: LocaleKeys.trade35.tr),
            ],
          ),
          InkWell(
            onTap: () {
              RouteUtil.goTo('/follow-orders');
            },
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 12.w).copyWith(bottom: 2),
              height: 38.h,
              alignment: Alignment.center,
              child: Text(LocaleKeys.public18.tr,
                  style: AppTextStyle.f_14_500.colorABABAB),
            ),
          ),
        ],
      ),
    );
  }
}
