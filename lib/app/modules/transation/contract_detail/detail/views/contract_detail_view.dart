import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nt_app_flutter/app/config/theme/app_color.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/global/favorite/contract_favorite_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/contract/controllers/contract_controller.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_detail/contract_info/views/contract_info_view.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_detail/detail/widgets/bottom_bar_widget.dart';
import 'package:nt_app_flutter/app/modules/transation/contract_detail/price/views/contract_price_view.dart';
import 'package:nt_app_flutter/app/modules/transation/widgets/price/widgets/coin_detail_title.dart';
import 'package:nt_app_flutter/app/utils/utilities/route_util.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_page_back.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../../utils/utilities/contract_util.dart';
import '../../../../../widgets/basic/my_image.dart';
import '../../../../../widgets/basic/my_tab_underline_widget.dart';
import '../controllers/contract_detail_controller.dart';

class ContractDetailView extends GetView<ContractDetailController> {
  const ContractDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Screenshot(
          controller: controller.shotController,
          child: Scaffold(
            appBar: AppBar(
              title: Obx(
                () => CoinDetailTitle(
                  title:
                      '${controller.contractInfo.value?.firstName}${controller.contractInfo.value?.secondName}',
                  subTitle: controller.contractInfo.value?.getContractType,
                  onTap: () {
                    controller.swapContract();
                  },
                ),
              ),
              leading: MyPageBackWidget(
                onTap: () => Get.back(result: controller.contractInfo.value),
              ),
              centerTitle: false,
              titleSpacing: 0,
              actions: [
                GetBuilder<ContractOptionController>(builder: (logic) {
                  bool isOption =
                      logic.isOption(controller.contractInfo.value?.id ?? 0);
                  return MyImage(
                    isOption
                        ? 'assets/images/contract/detail_star_sel.svg'
                        : 'assets/images/contract/detail_star.svg',
                    width: isOption ? 20.w : 18.w,
                    onTap: () {
                      if (controller.contractInfo.value != null) {
                        ContractOptionController.to.updateContractOption(
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
                      const ContractPriceView(),
                      Obx(() {
                        return ContractInfoView(
                          contractInfo: controller.contractInfo.value,
                          openTime: null,
                          maxLevel: controller.maxLevel.value ?? 0,
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
            bottomNavigationBar: Obx(() {
              return BottomBarWidget(
                contractInfo: controller.contractInfo.value,
                onTapTrade: () {
                  if (controller.contractInfo.value != null) {
                    ContractController.to
                        .changeContractInfo(controller.contractInfo.value!);
                    goToTrade(1, contractInfo: controller.contractInfo.value);
                  }
                },
              );
            }),
          ),
        ),
      ),
    );
  }

  _buildTab() {
    return Container(
      height: 38.h,
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
