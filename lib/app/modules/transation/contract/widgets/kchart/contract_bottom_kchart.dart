import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:k_chart/chart_style.dart';
import 'package:k_chart/chart_translations.dart';
import 'package:k_chart/entity/k_line_entity.dart';
import 'package:k_chart/k_chart_widget.dart';
import 'package:k_chart/renderer/main_renderer.dart';
import 'package:nt_app_flutter/app/config/theme/app_text_style.dart';
import 'package:nt_app_flutter/app/utils/utils.dart';
import 'package:nt_app_flutter/app/widgets/basic/my_image.dart';
import 'package:nt_app_flutter/generated/locales.g.dart';

import '../../../../../config/theme/app_color.dart';
import '../../../../../widgets/components/transaction/custom_loading_progress_indicator.dart';
import '../../../../../widgets/tab_indicator/tab_indicator.dart';
import '../../../widgets/price/widgets/kchart/model/sub_time.dart';
import '../../controllers/contract_bottom_kchart_controller.dart';

class ContractBottomKchartStateRx {
  RxList<KLineEntity> kLineData = RxList<KLineEntity>();
  RxBool isLoading = false.obs;
  Rx<SubTime> subTime = SubTime.contractTrade()[3].obs;
  Rx<MainState> mainState = MainState.MA.obs;
  RxBool isShowVol = true.obs;
  Rx<SecondaryState> secondaryState = SecondaryState.MACD.obs;
}

class ContractBottomKchart extends GetView<ContractBottomKChartController> {
  const ContractBottomKchart({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 0.5,
              color: AppColor.colorBorderGutter,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 34.h,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 0.5,
                    color: AppColor.colorBorderGutter,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  controller.isShow.value
                      ? Expanded(child: _buildSubTitle())
                      : _buildTitle(),
                  InkWell(
                    onTap: () {
                      controller.toggleShow();
                    },
                    child: AnimatedRotation(
                      duration: const Duration(milliseconds: 200),
                      turns: controller.isShow.value ? 0 : 0.5,
                      child: Container(
                        width: 34.w,
                        height: 34.h,
                        alignment: Alignment.center,
                        child: MyImage(
                          'assets/images/trade/entrust_filter_arrow.svg',
                          width: 16.w,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              height: controller.isShow.value ? 192.h : 0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 192.h,
                  child: Obx(() {
                    if (controller.state.isLoading.value) {
                      return const CustomLoadingProgressIndicator();
                    }
                    return KChartWidget(
                      controller.state.kLineData.value,
                      ChartStyle(),
                      ChartColors(),
                      isLine: controller.state.subTime.value.id == 1,
                      onSecondaryTap: () {},
                      isTrendLine: false,
                      mainState: MainState.MA,
                      volHidden: true,
                      secondaryState: SecondaryState.NONE,
                      timeFormat: TimeFormat.YEAR_MONTH_DAY,
                      translations: kChartTranslations,
                      showNowPrice: true,
                      hideGrid: false,
                      isTapShowInfoDialog: true,
                      verticalTextAlignment: VerticalTextAlignment.right,
                      onLoadMore: (value) {
                        if (!value) {
                          controller.onLoadMore();
                        }
                      },
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSubTitle() {
    return SizedBox(
      height: 22.h,
      child: TabBar(
          isScrollable: true,
          controller: controller.tabController,
          indicator: ColorTabIndicator(
            color: AppColor.colorBackgroundTertiary,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            radius: 20,
          ),
          onTap: (index) {
            controller.changeSubTime(SubTime.contractTrade()[index]);
          },
          labelStyle: AppTextStyle.f_11_400.colorTextPrimary,
          unselectedLabelStyle: AppTextStyle.f_11_400.colorTextTips,
          tabs: SubTime.contractTrade().map((e) {
            return Tab(
              text: e.title,
            );
          }).toList()),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Text(
        '${controller.contractInfo.value?.firstName ?? '-'}${controller.contractInfo.value?.secondName ?? '-'} ${LocaleKeys.trade366.tr}',
        style: AppTextStyle.f_11_400.colorTextPrimary,
      ),
    );
  }
}
